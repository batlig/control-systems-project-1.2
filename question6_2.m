%% MCH 3008 Control Systems - Project 1.2
%% Question 6.2: Lag Compensator Design
% G(s) = 100 / [(s+1)(s+7)]
% Specifications: Mp <= 50%, wn = 20, ess <= 0.001
% Use root locus approach and LAG compensator

clear; clc; close all;

%% ========================================================================
%% STEP 1: ANALYZE DESIGN SPECIFICATIONS
%% ========================================================================
fprintf('=== QUESTION 6.2: LAG COMPENSATOR DESIGN ===\n\n');

% Given specifications
Mp_spec = 0.50;      % Overshoot <= 50%
wn_spec = 20;        % Natural frequency = 20 rad/s
ess_spec = 0.001;    % Steady-state error <= 0.001

fprintf('DESIGN SPECIFICATIONS:\n');
fprintf('  Overshoot: Mp <= %.0f%%\n', Mp_spec*100);
fprintf('  Natural frequency: wn = %.0f rad/s\n', wn_spec);
fprintf('  Steady-state error: ess <= %.3f\n\n', ess_spec);

%% Step 1a: Find required damping ratio from Mp
% Mp = exp(-pi*zeta/sqrt(1-zeta^2))
% For Mp = 0.50: zeta >= 0.215
% We'll use zeta = 0.22 for exact match
zeta_min = 0.215;
zeta = 0.22;  % Select slightly higher for margin
Mp_check = exp(-pi*zeta/sqrt(1-zeta^2));
fprintf('From Mp <= 50%%:\n');
fprintf('  Required zeta >= %.3f\n', zeta_min);
fprintf('  Selected zeta = %.2f (gives Mp = %.1f%%)\n\n', zeta, Mp_check*100);

%% Step 1b: Desired pole locations
% s = -zeta*wn ± j*wn*sqrt(1-zeta^2)
wn = wn_spec;
sigma = zeta * wn;           % Real part
wd = wn * sqrt(1 - zeta^2);  % Imaginary part

s_desired = -sigma + 1j*wd;
fprintf('Desired dominant poles:\n');
fprintf('  s = -%.2f ± j%.2f\n', sigma, wd);
fprintf('  |s| = wn = %.0f rad/s\n\n', abs(s_desired));

%% ========================================================================
%% STEP 2: CHECK STEADY-STATE ERROR REQUIREMENT
%% ========================================================================
% For unit step input: ess = 1/(1+Kp)
% Required: ess <= 0.001 => Kp >= 999
Kp_required = (1/ess_spec) - 1;
fprintf('Steady-state error requirement:\n');
fprintf('  ess = 1/(1+Kp) <= 0.001\n');
fprintf('  Required Kp >= %.0f\n\n', Kp_required);

% Plant: G(s) = 100/[(s+1)(s+7)]
% Kp_plant = lim(s->0) G(s) = 100/7 = 14.29
Kp_plant = 100 / (1*7);
fprintf('Plant Kp = %.2f (need Kp >= %.0f)\n', Kp_plant, Kp_required);
fprintf('Ratio needed from lag: %.1f\n\n', Kp_required/Kp_plant);

%% ========================================================================
%% STEP 3: CHECK IF DESIRED POLES ARE ON ROOT LOCUS
%% ========================================================================
fprintf('=== CHECKING ROOT LOCUS CONDITION ===\n\n');

% Plant transfer function
num_G = 100;
den_G = conv([1 1], [1 7]);  % (s+1)(s+7) = s^2 + 8s + 7
G = tf(num_G, den_G);

% Evaluate angle at desired pole
s_d = s_desired;
G_at_sd = evalfr(G, s_d);
angle_G = angle(G_at_sd) * 180/pi;

fprintf('At s = %.2f + j%.2f:\n', real(s_d), imag(s_d));
fprintf('  Angle of G(s) = %.2f°\n', angle_G);
fprintf('  For RL: need angle = 180° (or odd multiple)\n');

% Angle deficiency
angle_deficiency = 180 - abs(angle_G);
if abs(angle_deficiency) < 5
    fprintf('  Angle deficiency = %.2f° (acceptable with pure gain)\n\n', angle_deficiency);
else
    fprintf('  Angle deficiency = %.2f° (may need compensation)\n\n', angle_deficiency);
end

%% ========================================================================
%% STEP 4: DESIGN LAG COMPENSATOR
%% ========================================================================
fprintf('=== LAG COMPENSATOR DESIGN ===\n\n');

% Lag compensator: C(s) = K * (s + z_lag) / (s + p_lag)
% where z_lag > p_lag (zero closer to origin than pole)
% DC gain ratio: beta = z_lag / p_lag

% Step 4a: Find gain K needed to place poles at desired location
% (assuming lag doesn't significantly affect angle near desired poles)
K_at_sd = 1 / abs(G_at_sd);
fprintf('Gain K to place poles at desired location:\n');
fprintf('  K = 1/|G(s_d)| = %.4f\n\n', K_at_sd);

% Step 4b: Calculate Kp with just gain K
Kp_with_K = K_at_sd * Kp_plant;
fprintf('Kp with gain K only: %.2f\n', Kp_with_K);

% Step 4c: Required lag ratio beta
beta_required = Kp_required / Kp_with_K;
fprintf('Required lag ratio beta >= %.2f\n\n', beta_required);

% Add safety margin
beta = ceil(beta_required * 1.2);  % 20% margin
fprintf('Selected beta = %.0f (with 20%% margin)\n\n', beta);

% Step 4d: Place lag zero and pole
% Rule: Place lag zero at least 1 decade below desired pole frequency
% z_lag should be small to not affect phase at wn
z_lag = 2;  % Place at s = -2 (well below wn = 20)
p_lag = z_lag / beta;

fprintf('Lag compensator:\n');
fprintf('  z_lag = %.2f\n', z_lag);
fprintf('  p_lag = z_lag/beta = %.2f/%.0f = %.4f\n', z_lag, beta, p_lag);

% Lag compensator transfer function
C_lag = tf([1 z_lag], [1 p_lag]);
fprintf('\n  C_lag(s) = (s + %.2f) / (s + %.4f)\n\n', z_lag, p_lag);

%% ========================================================================
%% STEP 5: COMPLETE CONTROLLER
%% ========================================================================
fprintf('=== FINAL CONTROLLER ===\n\n');

% Adjust K to account for lag compensator's effect on magnitude
C_lag_at_sd = evalfr(C_lag, s_d);
K_adjusted = K_at_sd / abs(C_lag_at_sd);

fprintf('Adjusting K for lag effect at s_d:\n');
fprintf('  |C_lag(s_d)| = %.4f\n', abs(C_lag_at_sd));
fprintf('  K_adjusted = %.4f\n\n', K_adjusted);

% Final controller
C = K_adjusted * C_lag;
fprintf('Final Controller:\n');
C

%% ========================================================================
%% VERIFICATION
%% ========================================================================
fprintf('=== VERIFICATION ===\n\n');

% Open-loop transfer function
L = C * G;

% Closed-loop transfer function
T = feedback(L, 1);

% Step response analysis
info = stepinfo(T);
ess_actual = abs(1 - dcgain(T));

fprintf('RESULTS vs SPECIFICATIONS:\n');
fprintf('---------------------------\n');

fprintf('Overshoot: %.2f%% (spec: <= %.0f%%) ', info.Overshoot, Mp_spec*100);
if info.Overshoot <= Mp_spec*100
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

% Check natural frequency (from closed-loop poles)
poles_CL = pole(T);
[~, idx] = max(imag(poles_CL));
wn_actual = abs(poles_CL(idx));
fprintf('Natural freq: %.2f rad/s (spec: = %.0f) ', wn_actual, wn_spec);
if abs(wn_actual - wn_spec) / wn_spec < 0.1  % within 10%
    fprintf('✓ PASS\n');
else
    fprintf('~ CLOSE\n');
end

fprintf('Steady-state error: %.6f (spec: <= %.3f) ', ess_actual, ess_spec);
if ess_actual <= ess_spec
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

fprintf('Rise Time: %.4f s\n', info.RiseTime);
fprintf('Settling Time: %.4f s\n\n', info.SettlingTime);

%% ========================================================================
%% PLOTS
%% ========================================================================

% Figure 1: Step Response and Root Locus
figure('Name', 'Question 6.2 - Step Response', 'Position', [100 100 1000 400]);

subplot(1,2,1);
step(T);
title('Closed-Loop Step Response', 'FontSize', 12);
xlabel('Time (s)');
ylabel('Output');
grid on;

subplot(1,2,2);
rlocus(L);
hold on;
plot(real(s_desired), imag(s_desired), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
plot(real(s_desired), -imag(s_desired), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
title('Root Locus of C(s)G(s)', 'FontSize', 12);
legend('Root Locus', 'Desired Poles');
xlim([-25 5]);
grid on;
hold off;

% Figure 2: Bode Diagram
figure('Name', 'Question 6.2 - Bode Diagram', 'Position', [100 100 800 600]);
margin(L);
grid on;
title('Bode Diagram of C(s)G(s)', 'FontSize', 12);

% Get margins
[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Stability Margins:\n');
fprintf('  Gain Margin: %.2f dB at %.2f rad/s\n', 20*log10(Gm), Wcg);
fprintf('  Phase Margin: %.2f° at %.2f rad/s\n\n', Pm, Wcp);

%% Save figures
saveas(1, 'question6_2_step_response.png');
saveas(2, 'question6_2_bode.png');
fprintf('Figures saved!\n');

%% Display final controller
fprintf('\n========================================\n');
fprintf('FINAL CONTROLLER SUMMARY\n');
fprintf('========================================\n');
fprintf('Controller type: Lag Compensator\n');
fprintf('C(s) = %.4f * (s + %.2f) / (s + %.4f)\n', K_adjusted, z_lag, p_lag);
fprintf('Beta (lag ratio) = %.0f\n', beta);
fprintf('========================================\n');
