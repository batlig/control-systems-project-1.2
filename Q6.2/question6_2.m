%% MCH 3008 Control Systems - Project 1.2
%% Question 6.2: Lag Compensator Design (ALL SPECS MET!)
%
% G(s) = 100 / [(s+1)(s+7)]
%
% Specifications:
%   - Overshoot: Mp <= 50%
%   - Natural frequency: wn = 20 rad/s  
%   - Steady-state error: ess <= 0.001
%
% SOLUTION: Lag compensator with very low frequency zero/pole

clear; clc; close all;

fprintf('=== Q6.2: LAG COMPENSATOR - ALL SPECS MET! ===\n\n');

s = tf('s');
G = 100 / ((s+1)*(s+7));

%% Design parameters
zeta = 0.30;  % Higher than theoretical 0.215 to account for system being > 2nd order
wn = 20;

sigma = zeta * wn;  % = 6
wd = wn * sqrt(1 - zeta^2);  % = 19.08
s_d = -sigma + 1j*wd;

fprintf('Design Parameters:\n');
fprintf('  ζ = %.2f (gives theoretical Mp = %.1f%%)\n', zeta, 100*exp(-pi*zeta/sqrt(1-zeta^2)));
fprintf('  ωn = %.0f rad/s\n', wn);
fprintf('  Desired poles: s = -%.2f ± j%.2f\n\n', sigma, wd);

%% Find gain K
K = 1 / abs(evalfr(G, s_d));
fprintf('Gain K = %.4f\n\n', K);

%% Lag compensator with VERY LOW frequencies
% This minimizes phase impact at ωn = 20
z_lag = 0.1;   % Very low frequency
p_lag = 0.0008;  % β = 125

C_lag = (s + z_lag) / (s + p_lag);

% Phase contribution at ωn
phase_at_wn = atan(wn/z_lag)*180/pi - atan(wn/p_lag)*180/pi;
fprintf('Lag Compensator:\n');
fprintf('  C_lag(s) = (s + %.2f) / (s + %.4f)\n', z_lag, p_lag);
fprintf('  β = z_lag/p_lag = %.0f\n', z_lag/p_lag);
fprintf('  Phase at ωn=20: %.2f° (negligible!)\n\n', phase_at_wn);

%% Final controller
C = K * C_lag;
fprintf('Final Controller:\n');
C

%% Closed-loop system
L = C * G;
T = feedback(L, 1);

%% Verification (use longer simulation for ess)
fprintf('\n=== VERIFICATION (100s simulation) ===\n\n');

[y, t] = step(T, 100);
info = stepinfo(T);

% Overshoot
fprintf('Overshoot: %.2f%% (spec: <= 50%%) ', info.Overshoot);
if info.Overshoot <= 50
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

% Natural frequency
wn_actual = pi / (info.PeakTime * sqrt(1 - zeta^2));
fprintf('Natural freq: %.1f rad/s (spec: = 20) ', wn_actual);
if abs(wn_actual - 20) < 2
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

% Steady-state error (at t = 100s)
ess = abs(1 - y(end));
fprintf('Steady-state error: %.6f (spec: <= 0.001) ', ess);
if ess <= 0.001
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end

fprintf('\nRise Time: %.4f s\n', info.RiseTime);
fprintf('Settling Time: %.4f s\n', info.SettlingTime);

%% Summary
fprintf('\n=== FINAL SOLUTION ===\n\n');
fprintf('Controller: C(s) = %.4f * (s + %.2f) / (s + %.4f)\n\n', K, z_lag, p_lag);
fprintf('           C(s) = %.4f(s + 0.1) / (s + 0.0008)\n\n', K);

fprintf('Key insights:\n');
fprintf('  1. Use ζ = 0.30 (not 0.22) to account for higher-order effects\n');
fprintf('  2. Place lag at very low frequencies (0.1, 0.0008) to minimize phase impact\n');
fprintf('  3. High β = 125 provides large DC gain boost for ess\n');
fprintf('  4. Need long simulation (100s) to see true steady-state (slow lag pole)\n');

%% Plots
figure('Name', 'Q6.2 Final Solution', 'Position', [100 100 1200 400]);

subplot(1,3,1);
step(T, 5);
hold on;
yline(1, 'g--', 'LineWidth', 1.5);
yline(1.5, 'r--', 'Mp=50%', 'LineWidth', 1.5);
title('Step Response (0-5s)');
xlabel('Time (s)');
ylabel('Output');
grid on;

subplot(1,3,2);
margin(L);
title('Open-Loop Bode');

subplot(1,3,3);
rlocus(C*G);
hold on;
plot(real(s_d), imag(s_d), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
plot(real(s_d), -imag(s_d), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
title('Root Locus');
xlim([-30 5]);
ylim([-25 25]);
legend('Root Locus', 'Desired Poles');

saveas(gcf, 'question6_2_solution.png');
fprintf('\nFigure saved: question6_2_solution.png\n');

%% Bode diagram without MATLAB (for parts c and d)
fprintf('\n=== BODE DIAGRAM INFO (for hand-drawn) ===\n\n');
fprintf('Open-loop L(s) = C(s)G(s) break frequencies:\n');
fprintf('  ω = 0.0008 rad/s (lag pole)\n');
fprintf('  ω = 0.1 rad/s (lag zero)\n');
fprintf('  ω = 1 rad/s (plant pole)\n');
fprintf('  ω = 7 rad/s (plant pole)\n\n');

Kp = dcgain(C) * dcgain(G);
fprintf('DC gain = %.2f = %.1f dB\n', Kp, 20*log10(Kp));
fprintf('High-frequency slope: -40 dB/dec (2 plant poles)\n');
