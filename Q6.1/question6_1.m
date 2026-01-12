%% MCH 3008 Control Systems - Project 1.2
%% Question 6.1: Lead-Lag Controller Design
% G(s) = 1 / [(s+4)(s+6)]
% Specifications: tr < 0.18s, Mp < 20%, ess < 0.01

clear; clc; close all;

%% ========================================================================
%% STEP 1: ANALYZE DESIGN SPECIFICATIONS
%% ========================================================================
fprintf('=== QUESTION 6.1: CONTROLLER DESIGN ===\n\n');

% Given specifications
tr_spec = 0.18;      % Rise time < 0.18 seconds
Mp_spec = 0.20;      % Overshoot < 20%
ess_spec = 0.01;     % Steady-state error < 0.01

fprintf('DESIGN SPECIFICATIONS:\n');
fprintf('  Rise time: tr < %.2f s\n', tr_spec);
fprintf('  Overshoot: Mp < %.0f%%\n', Mp_spec*100);
fprintf('  Steady-state error: ess < %.2f\n\n', ess_spec);

%% Step 1a: Find required damping ratio from Mp
% Mp = exp(-pi*zeta/sqrt(1-zeta^2))
% For Mp = 0.20: zeta >= 0.456
% We'll use zeta = 0.5 for some margin
zeta = 0.5;
Mp_check = exp(-pi*zeta/sqrt(1-zeta^2));
fprintf('From Mp < 20%%:\n');
fprintf('  Required zeta >= 0.456\n');
fprintf('  Selected zeta = %.2f (gives Mp = %.1f%%)\n\n', zeta, Mp_check*100);

%% Step 1b: Find required natural frequency from tr
% tr ≈ 1.8/wn (for zeta = 0.5)
% wn > 1.8/0.18 = 10 rad/s
wn_min = 1.8 / tr_spec;
wn = 12;  % Select wn = 12 rad/s for margin
fprintf('From tr < 0.18s:\n');
fprintf('  Required wn > %.1f rad/s\n', wn_min);
fprintf('  Selected wn = %.0f rad/s\n\n', wn);

%% Step 1c: Calculate desired closed-loop pole locations
% s = -zeta*wn ± j*wn*sqrt(1-zeta^2)
sigma = zeta * wn;           % Real part = 6
wd = wn * sqrt(1 - zeta^2);  % Imaginary part = 10.39

s_desired = -sigma + 1j*wd;
fprintf('Desired dominant poles:\n');
fprintf('  s = %.2f ± j%.2f\n\n', -sigma, wd);

%% ========================================================================
%% STEP 2: CHECK STEADY-STATE ERROR REQUIREMENT
%% ========================================================================
% For unit step input: ess = 1/(1+Kp)
% Required: ess < 0.01 => Kp > 99
Kp_required = (1/ess_spec) - 1;
fprintf('Steady-state error requirement:\n');
fprintf('  ess = 1/(1+Kp) < 0.01\n');
fprintf('  Required Kp > %.0f\n\n', Kp_required);

% Original plant: G(s) = 1/[(s+4)(s+6)]
% Kp_plant = lim(s->0) G(s) = 1/24 = 0.0417
Kp_plant = 1/24;
fprintf('Plant Kp = %.4f (insufficient!)\n', Kp_plant);
fprintf('Need a LAG compensator to boost low-frequency gain.\n\n');

%% ========================================================================
%% STEP 3: DESIGN LEAD COMPENSATOR (for transient response)
%% ========================================================================
fprintf('=== LEAD COMPENSATOR DESIGN ===\n\n');

% Plant transfer function
G = tf(1, conv([1 4], [1 6]));
fprintf('Plant G(s) = 1/[(s+4)(s+6)]\n\n');

% Angle deficiency at desired pole location
% We need the root locus to pass through s_desired
s_d = s_desired;

% Calculate angle contribution from plant poles
angle_p1 = angle(s_d - (-4)) * 180/pi;  % from pole at -4
angle_p2 = angle(s_d - (-6)) * 180/pi;  % from pole at -6
angle_plant = angle_p1 + angle_p2;

fprintf('Angle contributions at s = %.2f + j%.2f:\n', real(s_d), imag(s_d));
fprintf('  From pole at -4: %.2f°\n', angle_p1);
fprintf('  From pole at -6: %.2f°\n', angle_p2);
fprintf('  Total from plant: %.2f°\n', angle_plant);

% Required angle from lead compensator
% For point on root locus: sum of angles = 180°
angle_deficiency = 180 - angle_plant;
fprintf('  Angle deficiency: %.2f°\n\n', angle_deficiency);

% Lead compensator: C_lead(s) = Kc * (s+z)/(s+p), where p > z
% We need to provide angle_deficiency
% Place zero at z = 6 (cancel plant pole) - simplified approach
% Actually, let's use proper lead design

% Place lead zero at z_lead = 6 (near the slower plant pole)
z_lead = 6;
angle_from_zero = angle(s_d - (-z_lead)) * 180/pi;

% Required angle from lead pole
angle_from_pole_required = angle_from_zero - angle_deficiency;
% But this needs to be positive, so:
phi_lead = angle_deficiency;  % Lead must provide this angle

fprintf('Lead compensator design:\n');
fprintf('  Required phase lead: %.2f°\n', phi_lead);

% Using the formula: sin(phi) = (p-z)/(p+z) for maximum phase
% Or graphical method: place zero, find pole location
% Let's place zero at z = 4 to partially cancel effect
z_lead = 5;

% Find pole location using angle condition
% angle(s_d + z_lead) - angle(s_d + p_lead) = phi_lead
angle_zero = angle(s_d - (-z_lead)) * 180/pi;

% Required pole angle
angle_pole_needed = angle_zero - phi_lead;
% p_lead location: use geometry
% tan(angle_pole_needed) = wd / (sigma - p_lead)
p_lead = sigma + wd / tand(angle_pole_needed);

fprintf('  Lead zero: z_lead = %.2f\n', z_lead);
fprintf('  Lead pole: p_lead = %.2f\n', p_lead);

% Create lead compensator (without gain for now)
C_lead = tf([1 z_lead], [1 p_lead]);
fprintf('\n  C_lead(s) = (s + %.2f)/(s + %.2f)\n\n', z_lead, p_lead);

%% ========================================================================
%% STEP 4: DESIGN LAG COMPENSATOR (for steady-state error)
%% ========================================================================
fprintf('=== LAG COMPENSATOR DESIGN ===\n\n');

% Lag compensator: C_lag(s) = (s + z_lag)/(s + p_lag), where z_lag > p_lag
% Gain at DC: z_lag/p_lag = beta (lag ratio)

% Required Kp > 99
% Current Kp with lead: Kp_lead = (z_lead/p_lead) * (1/24)
Kp_with_lead = (z_lead/p_lead) * (1/24);
fprintf('Kp with lead only: %.4f\n', Kp_with_lead);

% Need additional gain from lag: beta = Kp_required / Kp_with_lead
beta = Kp_required / Kp_with_lead;
fprintf('Required lag ratio beta = %.2f\n', beta);

% Increase beta for safety margin
beta = beta * 1.5;  % 50% margin
fprintf('Selected beta (with margin) = %.2f\n\n', beta);

% Place lag zero at z_lag = 0.5 (at least 10x below dominant pole frequency)
z_lag = 0.5;
p_lag = z_lag / beta;

fprintf('Lag compensator:\n');
fprintf('  z_lag = %.3f\n', z_lag);
fprintf('  p_lag = %.5f\n', p_lag);

C_lag = tf([1 z_lag], [1 p_lag]);
fprintf('\n  C_lag(s) = (s + %.3f)/(s + %.5f)\n\n', z_lag, p_lag);

%% ========================================================================
%% STEP 5: DETERMINE OVERALL GAIN K
%% ========================================================================
fprintf('=== FINDING CONTROLLER GAIN K ===\n\n');

% Combined compensator (without K)
C_no_gain = C_lead * C_lag;

% Open-loop: L(s) = K * C(s) * G(s)
L_no_gain = C_no_gain * G;

% Find K such that root locus passes through s_desired
% |K * L(s_d)| = 1
L_at_sd = evalfr(L_no_gain, s_d);
K = 1 / abs(L_at_sd);

fprintf('Gain K = %.4f\n\n', K);

%% ========================================================================
%% FINAL CONTROLLER
%% ========================================================================
fprintf('=== FINAL CONTROLLER ===\n\n');

C = K * C_lead * C_lag;
fprintf('C(s) = K * C_lead(s) * C_lag(s)\n\n');
fprintf('Final Controller:\n');
C

% Simplify to standard form
[num_C, den_C] = tfdata(C, 'v');
fprintf('C(s) = %.4f * (s + %.2f)(s + %.3f) / [(s + %.2f)(s + %.5f)]\n\n', ...
    K, z_lead, z_lag, p_lead, p_lag);

%% ========================================================================
%% PART B: SIMULATION
%% ========================================================================
fprintf('=== PART B: SIMULATION RESULTS ===\n\n');

% Closed-loop transfer function
L = C * G;              % Open-loop
T = feedback(L, 1);     % Closed-loop with unity feedback

% Step response
figure('Name', 'Question 6.1 - Step Response', 'Position', [100 100 1000 400]);

subplot(1,2,1);
step(T);
title('Closed-Loop Step Response', 'FontSize', 12);
xlabel('Time (s)');
ylabel('Output');
grid on;

% Get step response info
info = stepinfo(T);
fprintf('Step Response Characteristics:\n');
fprintf('  Rise Time: %.4f s (spec: < %.2f s) ', info.RiseTime, tr_spec);
if info.RiseTime < tr_spec
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

fprintf('  Overshoot: %.2f%% (spec: < %.0f%%) ', info.Overshoot, Mp_spec*100);
if info.Overshoot < Mp_spec*100
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

fprintf('  Settling Time: %.4f s\n', info.SettlingTime);

% Steady-state error
ess_actual = abs(1 - dcgain(T));
fprintf('  Steady-State Error: %.6f (spec: < %.2f) ', ess_actual, ess_spec);
if ess_actual < ess_spec
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

subplot(1,2,2);
rlocus(L);
hold on;
plot(real(s_desired), imag(s_desired), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
plot(real(s_desired), -imag(s_desired), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
title('Root Locus of C(s)G(s)', 'FontSize', 12);
legend('Root Locus', 'Desired Poles', 'Location', 'best');
grid on;
hold off;

%% ========================================================================
%% PARTS C & D: BODE DIAGRAMS
%% ========================================================================
fprintf('\n=== PARTS C & D: BODE DIAGRAM ===\n\n');

figure('Name', 'Question 6.1 - Bode Diagram', 'Position', [100 100 800 600]);
bode(L);
grid on;
title('Bode Diagram of C(s)G(s)', 'FontSize', 12);
margin(L);

% Get margins
[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Stability Margins:\n');
fprintf('  Gain Margin: %.2f dB at %.2f rad/s\n', 20*log10(Gm), Wcg);
fprintf('  Phase Margin: %.2f° at %.2f rad/s\n', Pm, Wcp);

%% Save figures
saveas(1, 'question6_1_step_response.png');
saveas(2, 'question6_1_bode.png');
fprintf('\nFigures saved!\n');

%% Display final controller
fprintf('\n========================================\n');
fprintf('FINAL CONTROLLER SUMMARY\n');
fprintf('========================================\n');
fprintf('Controller type: Lead-Lag\n');
fprintf('C(s) = %.2f * [(s+%.1f)/(s+%.1f)] * [(s+%.2f)/(s+%.4f)]\n', ...
    K, z_lead, p_lead, z_lag, p_lag);
fprintf('========================================\n');
