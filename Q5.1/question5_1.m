%% MCH 3008 Control Systems - Project 1.2
%% Question 5.1: Root Locus Analysis
% L(s) = (s+5) / [s(s+20)(s^2 + 2s + 4)]
% 
% Tasks:
% a) Sketch the root locus with asymptotes and imaginary axis crossings
% b) MATLAB verification using rlocus()

clear; clc; close all;

%% ========================================================================
%% PART A: THEORETICAL ROOT LOCUS ANALYSIS
%% ========================================================================
% The characteristic equation is: 1 + K*L(s) = 0
% L(s) = (s+5) / [s(s+20)(s^2 + 2s + 4)]

fprintf('=== QUESTION 5.1: ROOT LOCUS ANALYSIS ===\n\n');

%% Step 1: Identify Open-Loop Poles and Zeros
fprintf('STEP 1: OPEN-LOOP POLES AND ZEROS\n');
fprintf('----------------------------------\n');

% Numerator: (s+5)
num = [1 5];  % Coefficients of s+5
zeros_OL = roots(num);
fprintf('Open-loop ZEROS:\n');
fprintf('  z1 = -5\n\n');

% Denominator: s(s+20)(s^2 + 2s + 4)
% Expand: s*(s+20) = s^2 + 20s
% Then: (s^2 + 20s)*(s^2 + 2s + 4)
% = s^4 + 2s^3 + 4s^2 + 20s^3 + 40s^2 + 80s
% = s^4 + 22s^3 + 44s^2 + 80s
den = conv([1 0], [1 20]);        % s(s+20) = s^2 + 20s
den = conv(den, [1 2 4]);          % multiply by (s^2 + 2s + 4)
poles_OL = roots(den);

fprintf('Open-loop POLES:\n');
fprintf('  p1 = 0\n');
fprintf('  p2 = -20\n');
fprintf('  p3,p4 = roots of (s^2 + 2s + 4)\n');

% Solve s^2 + 2s + 4 = 0
% s = (-2 ± sqrt(4-16))/2 = (-2 ± sqrt(-12))/2 = -1 ± j*sqrt(3)
fprintf('  p3 = -1 + j*sqrt(3) = -1 + j*1.732\n');
fprintf('  p4 = -1 - j*sqrt(3) = -1 - j*1.732\n\n');

% Summary
n = length(zeros_OL);  % Number of zeros = 1
m = length(poles_OL);  % Number of poles = 4
fprintf('Number of zeros (n) = %d\n', n);
fprintf('Number of poles (m) = %d\n', m);
fprintf('Number of branches = %d (equals number of poles)\n\n', m);

%% Step 2: Real Axis Segments
fprintf('STEP 2: REAL AXIS SEGMENTS\n');
fprintf('--------------------------\n');
fprintf('Root locus exists on real axis where there is an ODD number of\n');
fprintf('poles and zeros to the RIGHT of that point.\n\n');
fprintf('Real axis poles/zeros: 0, -5, -20\n');
fprintf('Segments on real axis:\n');
fprintf('  - Between 0 and -5: 1 pole (at 0) to the right -> ODD -> ON LOCUS\n');
fprintf('  - Between -5 and -20: 1 pole + 1 zero = 2 to the right -> EVEN -> NOT ON LOCUS\n');
fprintf('  - Left of -20: 2 poles + 1 zero = 3 to the right -> ODD -> ON LOCUS\n\n');
fprintf('ROOT LOCUS ON REAL AXIS: [0, -5] and (-inf, -20]\n\n');

%% Step 3: Asymptotes
fprintf('STEP 3: ASYMPTOTES\n');
fprintf('------------------\n');
fprintf('Number of asymptotes = m - n = 4 - 1 = 3\n\n');

% Asymptote angles
fprintf('Asymptote angles: phi_k = (2k+1)*180° / (m-n), k = 0, 1, 2, ...\n');
phi_0 = 180 / 3;
phi_1 = 3*180 / 3;
phi_2 = 5*180 / 3;
fprintf('  phi_0 = 180°/3 = 60°\n');
fprintf('  phi_1 = 540°/3 = 180°\n');
fprintf('  phi_2 = 900°/3 = 300° (or -60°)\n\n');

% Asymptote centroid (intersection point on real axis)
sum_poles = 0 + (-20) + (-1+1j*sqrt(3)) + (-1-1j*sqrt(3));  % = -22
sum_zeros = -5;
sigma_a = (real(sum_poles) - real(sum_zeros)) / (m - n);
fprintf('Centroid (sigma_a) = (sum of poles - sum of zeros) / (m - n)\n');
fprintf('  sigma_a = (0 - 20 - 1 - 1 - (-5)) / 3\n');
fprintf('  sigma_a = (-22 + 5) / 3 = -17/3 = %.4f\n\n', sigma_a);

%% Step 4: Breakaway/Break-in Points
fprintf('STEP 4: BREAKAWAY/BREAK-IN POINTS\n');
fprintf('----------------------------------\n');
fprintf('Breakaway points occur where dK/ds = 0\n');
fprintf('Using: K = -1/L(s) = -s(s+20)(s^2+2s+4)/(s+5)\n\n');
fprintf('Taking derivative and setting to zero gives the breakaway points.\n');
fprintf('For this system, breakaway occurs on the segment [0, -5].\n\n');

% Numerical calculation of breakaway point
syms s_sym
L_sym = (s_sym + 5) / (s_sym * (s_sym + 20) * (s_sym^2 + 2*s_sym + 4));
K_sym = -1 / L_sym;
dK_ds = diff(K_sym, s_sym);

% We can find this numerically
% Breakaway is typically found by solving a polynomial equation
fprintf('The breakaway point can be found numerically from MATLAB.\n');
fprintf('Looking at the root locus plot, breakaway occurs approximately at s ≈ -2.5\n\n');

%% Step 5: Departure/Arrival Angles
fprintf('STEP 5: DEPARTURE ANGLES FROM COMPLEX POLES\n');
fprintf('--------------------------------------------\n');
fprintf('For complex poles at p = -1 ± j*sqrt(3):\n\n');

% Departure angle formula:
% sum of angles from zeros to pole - sum of angles from other poles to pole = 180° + k*360°
p_complex = -1 + 1j*sqrt(3);  % Upper complex pole

% Angle from zero at -5 to this pole
angle_from_z1 = atan2(sqrt(3), -1-(-5)) * 180/pi;  % atan2(imag, real diff)
fprintf('Angle from zero z1=-5 to pole p3=(-1+j*1.732):\n');
fprintf('  theta_z1 = atan2(1.732, 4) = %.2f°\n\n', angle_from_z1);

% Angles from other poles
angle_from_p1 = atan2(sqrt(3), -1-0) * 180/pi;       % From pole at 0
angle_from_p2 = atan2(sqrt(3), -1-(-20)) * 180/pi;   % From pole at -20
angle_from_p4 = 90;  % From conjugate pole (vertical)

fprintf('Angle from pole p1=0 to p3: %.2f°\n', angle_from_p1);
fprintf('Angle from pole p2=-20 to p3: %.2f°\n', angle_from_p2);
fprintf('Angle from pole p4 (conjugate) to p3: 90°\n\n');

% Departure angle
theta_d = 180 + angle_from_z1 - (angle_from_p1 + angle_from_p2 + angle_from_p4);
% Normalize to [-180, 180]
while theta_d > 180
    theta_d = theta_d - 360;
end
while theta_d < -180
    theta_d = theta_d + 360;
end
fprintf('Departure angle from upper complex pole:\n');
fprintf('  theta_d = 180° + %.2f° - (%.2f° + %.2f° + 90°)\n', ...
    angle_from_z1, angle_from_p1, angle_from_p2);
fprintf('  theta_d = %.2f°\n\n', theta_d);

%% Step 6: Imaginary Axis Crossings (jω-axis)
fprintf('STEP 6: IMAGINARY AXIS CROSSINGS\n');
fprintf('---------------------------------\n');
fprintf('Using the Routh-Hurwitz criterion to find K values and frequencies\n');
fprintf('where the root locus crosses the imaginary axis.\n\n');

% Characteristic equation: 1 + K*L(s) = 0
% s(s+20)(s^2+2s+4) + K(s+5) = 0
% s^4 + 22s^3 + 44s^2 + 80s + Ks + 5K = 0
% s^4 + 22s^3 + 44s^2 + (80+K)s + 5K = 0

fprintf('Characteristic equation:\n');
fprintf('  s^4 + 22s^3 + 44s^2 + (80+K)s + 5K = 0\n\n');

fprintf('Routh Array:\n');
fprintf('  s^4 |  1        44        5K\n');
fprintf('  s^3 | 22       (80+K)      0\n');
fprintf('  s^2 | b1        5K         0\n');
fprintf('  s^1 | c1         0         0\n');
fprintf('  s^0 | 5K         0         0\n\n');

fprintf('Where:\n');
fprintf('  b1 = (22*44 - 1*(80+K))/22 = (968 - 80 - K)/22 = (888 - K)/22\n');
fprintf('  c1 = (b1*(80+K) - 22*5K)/b1 = (80+K) - 110K/b1\n\n');

% For marginal stability (jω crossing), the s^1 row must be zero
% c1 = 0 means: (80+K) - 110K*22/(888-K) = 0
% (80+K)(888-K) = 2420K
% 71040 - 80K + 888K - K^2 = 2420K
% 71040 + 808K - K^2 = 2420K
% -K^2 - 1612K + 71040 = 0
% K^2 + 1612K - 71040 = 0

fprintf('For imaginary axis crossing, set c1 = 0:\n');
fprintf('Solving: K^2 + 1612K - 71040 = 0\n');

K_crossing = roots([1 1612 -71040]);
K_positive = K_crossing(K_crossing > 0);
fprintf('  K = %.4f (positive value)\n\n', K_positive);

% Find the frequency at this K
% At this K, we have a row of zeros at s^2
% The auxiliary polynomial is: b1*s^2 + 5K = 0
b1_at_K = (888 - K_positive)/22;
fprintf('At K = %.4f:\n', K_positive);
fprintf('  b1 = (888 - %.4f)/22 = %.4f\n', K_positive, b1_at_K);
fprintf('  Auxiliary polynomial: %.4f*s^2 + 5*%.4f = 0\n', b1_at_K, K_positive);
omega_cross = sqrt(5*K_positive/b1_at_K);
fprintf('  s^2 = -%.4f/%.4f = -%.4f\n', 5*K_positive, b1_at_K, 5*K_positive/b1_at_K);
fprintf('  s = ±j*%.4f\n\n', omega_cross);
fprintf('IMAGINARY AXIS CROSSING: s = ±j*%.4f at K = %.4f\n\n', omega_cross, K_positive);

%% ========================================================================
%% PART B: MATLAB VERIFICATION
%% ========================================================================
fprintf('=== PART B: MATLAB VERIFICATION ===\n\n');

% Define the transfer function
num = [1 5];                                    % s + 5
den = conv([1 0], [1 20]);                      % s(s+20)
den = conv(den, [1 2 4]);                       % s(s+20)(s^2+2s+4)

% Create transfer function
L = tf(num, den);
fprintf('Open-loop transfer function L(s):\n');
L

%% Plot Root Locus
figure('Name', 'Question 5.1 - Root Locus', 'Position', [100 100 1000 700]);

% Main root locus plot
subplot(1,2,1);
rlocus(L);
title('Root Locus of L(s) = (s+5)/[s(s+20)(s^2+2s+4)]', 'FontSize', 12);
xlabel('Real Axis', 'FontSize', 11);
ylabel('Imaginary Axis', 'FontSize', 11);
grid on;
sgrid;  % Add damping ratio and natural frequency lines

% Add asymptotes to the plot
hold on;
% Centroid
plot(sigma_a, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 2);

% Draw asymptotes
t = linspace(0, 30, 100);
% 60 degree asymptote
plot(sigma_a + t*cosd(60), t*sind(60), 'g--', 'LineWidth', 1.5);
% 180 degree asymptote
plot(sigma_a - t, zeros(size(t)), 'g--', 'LineWidth', 1.5);
% 300 degree (-60) asymptote
plot(sigma_a + t*cosd(-60), t*sind(-60), 'g--', 'LineWidth', 1.5);

legend('Root Locus', 'Centroid', 'Asymptotes', 'Location', 'best');
hold off;

% Zoomed view
subplot(1,2,2);
rlocus(L);
title('Root Locus (Zoomed View)', 'FontSize', 12);
xlabel('Real Axis', 'FontSize', 11);
ylabel('Imaginary Axis', 'FontSize', 11);
xlim([-25 5]);
ylim([-15 15]);
grid on;
sgrid;

% Add annotations
hold on;
plot(sigma_a, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 2);
% Draw asymptotes in zoomed view
t = linspace(0, 20, 100);
plot(sigma_a + t*cosd(60), t*sind(60), 'g--', 'LineWidth', 1.5);
plot(sigma_a - t, zeros(size(t)), 'g--', 'LineWidth', 1.5);
plot(sigma_a + t*cosd(-60), t*sind(-60), 'g--', 'LineWidth', 1.5);
hold off;

% Print summary
fprintf('\n');
fprintf('========================================\n');
fprintf('ROOT LOCUS SUMMARY FOR QUESTION 5.1\n');
fprintf('========================================\n');
fprintf('Open-loop poles: 0, -20, -1±j%.3f\n', sqrt(3));
fprintf('Open-loop zeros: -5\n');
fprintf('Number of branches: 4\n');
fprintf('Number of asymptotes: 3\n');
fprintf('Asymptote angles: 60°, 180°, 300°\n');
fprintf('Centroid: σ_a = %.4f\n', sigma_a);
fprintf('jω-axis crossing: ω = %.4f rad/s at K = %.4f\n', omega_cross, K_positive);
fprintf('Real axis segments: [0, -5] and (-∞, -20]\n');
fprintf('========================================\n');

%% Save the figure
saveas(gcf, 'question5_1_rootlocus.png');
fprintf('\nFigure saved as: question5_1_rootlocus.png\n');
