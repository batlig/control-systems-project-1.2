%% MCH 3008 Control Systems - Project 1.2
%% Question 8.2: Nyquist Diagram and Stability Analysis
% G(s) = 1 / (s^4 + 5)
% Forward path gain = 10
% Open-loop: L(s) = 10 / (s^4 + 5)
%
% Tasks:
% - Plot Nyquist diagram
% - Determine if closed-loop system is stable

clear; clc; close all;

%% ========================================================================
%% SYSTEM ANALYSIS
%% ========================================================================
fprintf('=== QUESTION 8.2: NYQUIST DIAGRAM ===\n\n');

%% Define the transfer function
% From the diagram: L(s) = 10 * G(s) = 10 / (s^4 + 5)
num = 10;
den = [1 0 0 0 5];  % s^4 + 5

L = tf(num, den);
fprintf('Open-loop transfer function L(s) = 10*G(s):\n');
L

%% Analyze poles
fprintf('=== POLE ANALYSIS ===\n\n');

poles_L = pole(L);
fprintf('Open-loop POLES (roots of s^4 + 5 = 0):\n');
fprintf('  s^4 = -5\n');
fprintf('  s = (-5)^(1/4) * e^(j*k*pi/2), k = 0,1,2,3\n\n');

% s^4 = -5 = 5*e^(j*pi)
% s = 5^(1/4) * e^(j*(pi + 2*k*pi)/4)
% For k=0: s = 5^0.25 * e^(j*pi/4) = 5^0.25 * (cos(45°) + j*sin(45°))
% For k=1: s = 5^0.25 * e^(j*3*pi/4)
% For k=2: s = 5^0.25 * e^(j*5*pi/4)
% For k=3: s = 5^0.25 * e^(j*7*pi/4)

r = 5^0.25;  % magnitude
for i = 1:length(poles_L)
    fprintf('  p%d = %.4f + j%.4f\n', i, real(poles_L(i)), imag(poles_L(i)));
end

% Count RHP poles
P = sum(real(poles_L) > 1e-6);
fprintf('\nNumber of RHP poles (P) = %d\n\n', P);

%% ========================================================================
%% NYQUIST CRITERION ANALYSIS
%% ========================================================================
fprintf('=== NYQUIST STABILITY CRITERION ===\n\n');

fprintf('Nyquist criterion: Z = N + P\n');
fprintf('  P = %d (open-loop RHP poles)\n\n', P);

fprintf('For STABILITY: Z = 0\n');
fprintf('  Need N = -P = -%d\n', P);
fprintf('  (i.e., %d counter-clockwise encirclements of -1)\n\n', P);

%% ========================================================================
%% CALCULATE KEY POINTS ON NYQUIST PLOT
%% ========================================================================
fprintf('=== KEY POINTS ON NYQUIST PLOT ===\n\n');

% L(jω) = 10 / ((jω)^4 + 5) = 10 / (ω^4 + 5)
% Note: (jω)^4 = ω^4 (real and positive!)
% So L(jω) is always REAL for all ω!

fprintf('L(jω) = 10 / ((jω)^4 + 5) = 10 / (ω^4 + 5)\n\n');
fprintf('Note: (jω)^4 = ω^4, so L(jω) is ALWAYS REAL!\n\n');

omega_test = [0, 0.5, 1, 1.5, 2, 5, 10];
fprintf('ω (rad/s)     L(jω) (real value)\n');
fprintf('----------------------------------\n');

for w = omega_test
    L_jw = 10 / (w^4 + 5);
    fprintf('  %6.2f      %8.4f\n', w, L_jw);
end

fprintf('\n');
fprintf('At ω = 0:   L(j0) = 10/5 = 2\n');
fprintf('At ω → ∞:  L(jω) → 0\n\n');

%% ========================================================================
%% NYQUIST PLOT SHAPE
%% ========================================================================
fprintf('=== NYQUIST PLOT SHAPE ===\n\n');

fprintf('Since L(jω) is always real and positive:\n');
fprintf('  - The Nyquist plot lies entirely on the POSITIVE real axis\n');
fprintf('  - It starts at L(0) = 2 when ω = 0\n');
fprintf('  - It decreases monotonically to 0 as ω → ∞\n');
fprintf('  - The plot for ω < 0 is the same (L(-jω) = L(jω))\n\n');

fprintf('The complete Nyquist plot is just a line segment\n');
fprintf('from 0 to 2 on the positive real axis!\n\n');

%% ========================================================================
%% DETERMINE STABILITY
%% ========================================================================
fprintf('=== STABILITY ANALYSIS ===\n\n');

fprintf('The Nyquist plot:\n');
fprintf('  - Lies on positive real axis from 0 to 2\n');
fprintf('  - Does NOT encircle or even approach the point -1\n');
fprintf('  - Number of encirclements N = 0\n\n');

fprintf('Applying Nyquist criterion:\n');
fprintf('  Z = N + P = 0 + %d = %d\n\n', P, P);

if P == 0
    fprintf('Since Z = 0, closed-loop has NO RHP poles.\n');
    fprintf('*** CLOSED-LOOP SYSTEM IS STABLE ***\n\n');
else
    fprintf('Since Z = %d > 0, closed-loop has %d RHP poles.\n', P, P);
    fprintf('*** CLOSED-LOOP SYSTEM IS UNSTABLE ***\n\n');
end

%% ========================================================================
%% VERIFICATION: Check closed-loop poles directly
%% ========================================================================
fprintf('=== VERIFICATION ===\n\n');

% Closed-loop TF: T = L/(1+L) = 10/(s^4 + 5 + 10) = 10/(s^4 + 15)
T = feedback(L, 1);
poles_CL = pole(T);

fprintf('Closed-loop transfer function:\n');
fprintf('  T(s) = 10 / (s^4 + 15)\n\n');

fprintf('Closed-loop poles (roots of s^4 + 15 = 0):\n');
for i = 1:length(poles_CL)
    fprintf('  p%d = %.4f + j%.4f', i, real(poles_CL(i)), imag(poles_CL(i)));
    if real(poles_CL(i)) > 0
        fprintf(' <- RHP!\n');
    else
        fprintf('\n');
    end
end

CL_RHP = sum(real(poles_CL) > 1e-6);
fprintf('\nClosed-loop RHP poles: %d\n', CL_RHP);
if CL_RHP == 0
    fprintf('CONFIRMED: System is STABLE\n\n');
else
    fprintf('CONFIRMED: System is UNSTABLE\n\n');
end

%% ========================================================================
%% PLOT NYQUIST DIAGRAM
%% ========================================================================
figure('Name', 'Question 8.2 - Nyquist Diagram', 'Position', [100 100 1000 500]);

% Standard Nyquist plot
subplot(1,2,1);
nyquist(L);
title('Nyquist Diagram of L(s) = 10/(s^4+5)', 'FontSize', 12);
grid on;
hold on;
plot(-1, 0, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
legend('Nyquist Plot', 'Critical Point (-1,0)', 'Location', 'best');
hold off;

% Manual plot showing the real-axis nature
subplot(1,2,2);
w = linspace(0, 10, 1000);
L_real = 10 ./ (w.^4 + 5);

plot(L_real, zeros(size(L_real)), 'b-', 'LineWidth', 2);
hold on;
plot(L_real, zeros(size(L_real)), 'b--', 'LineWidth', 2);  % Same for ω < 0
plot(-1, 0, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
plot(2, 0, 'go', 'MarkerSize', 10, 'LineWidth', 2);  % Starting point
xlabel('Real');
ylabel('Imaginary');
title('Nyquist Plot (lies on positive real axis)', 'FontSize', 12);
xlim([-2 3]);
ylim([-1 1]);
grid on;
legend('L(jω)', '', '-1 Point', 'L(0)=2', 'Location', 'best');
hold off;

%% Pole-Zero Map
figure('Name', 'Question 8.2 - Pole Locations', 'Position', [100 100 600 500]);
pzmap(L);
hold on;
xline(0, 'r--', 'LineWidth', 1.5);
title('Open-Loop Pole-Zero Map', 'FontSize', 12);
grid on;
hold off;

%% Save figures
saveas(1, 'question8_2_nyquist.png');
saveas(2, 'question8_2_poles.png');
fprintf('Figures saved!\n');

%% Summary
fprintf('\n========================================\n');
fprintf('QUESTION 8.2 SUMMARY\n');
fprintf('========================================\n');
fprintf('L(s) = 10 / (s^4 + 5)\n\n');
fprintf('Open-loop poles: 4 poles at 45°, 135°, 225°, 315°\n');
fprintf('  Two in RHP, two in LHP\n');
fprintf('RHP poles (P): %d\n', P);
fprintf('Encirclements of -1 (N): 0\n');
fprintf('Closed-loop RHP poles (Z): N + P = %d\n\n', P);
if P == 0
    fprintf('CONCLUSION: Closed-loop is STABLE\n');
else
    fprintf('CONCLUSION: Closed-loop is UNSTABLE\n');
end
fprintf('========================================\n');
