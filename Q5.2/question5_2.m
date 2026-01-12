%% MCH 3008 Control Systems - Project 1.2
%% Question 5.2: Root Locus Analysis (Unstable Plant)
% L(s) = s / [(s-1)(s+4)(s^2 + 6s + 9)]
% Note: This system has an UNSTABLE pole at s = +1
%
% Tasks:
% a) Sketch the root locus with asymptotes and imaginary axis crossings
% b) MATLAB verification using rlocus()

clear; clc; close all;

%% ========================================================================
%% PART A: THEORETICAL ROOT LOCUS ANALYSIS
%% ========================================================================
fprintf('=== QUESTION 5.2: ROOT LOCUS ANALYSIS ===\n\n');

%% Step 1: Identify Open-Loop Poles and Zeros
fprintf('STEP 1: OPEN-LOOP POLES AND ZEROS\n');
fprintf('----------------------------------\n');

% Numerator: s
num = [1 0];  % s
zeros_OL = roots(num);
fprintf('Open-loop ZEROS:\n');
fprintf('  z1 = 0 (at origin)\n\n');

% Denominator: (s-1)(s+4)(s^2 + 6s + 9)
% Note: s^2 + 6s + 9 = (s+3)^2 - repeated real pole!
poles_factor1 = [1 -1];   % (s-1) -> pole at +1 (UNSTABLE!)
poles_factor2 = [1 4];    % (s+4) -> pole at -4
poles_factor3 = [1 6 9];  % (s+3)^2 -> repeated pole at -3

den = conv(poles_factor1, poles_factor2);
den = conv(den, poles_factor3);

poles_OL = roots(den);
fprintf('Open-loop POLES:\n');
fprintf('  p1 = +1  (UNSTABLE - in RHP!)\n');
fprintf('  p2 = -4\n');
fprintf('  p3 = -3  (repeated)\n');
fprintf('  p4 = -3  (repeated)\n\n');

% Summary
n = 1;  % Number of zeros
m = 4;  % Number of poles
fprintf('Number of zeros (n) = %d\n', n);
fprintf('Number of poles (m) = %d\n', m);
fprintf('Number of branches = %d\n\n', m);

%% Step 2: Real Axis Segments
fprintf('STEP 2: REAL AXIS SEGMENTS\n');
fprintf('--------------------------\n');
fprintf('Root locus on real axis where ODD number of poles+zeros to the right.\n\n');
fprintf('Real axis poles/zeros (left to right): -4, -3 (x2), 0, +1\n\n');

fprintf('Checking each segment:\n');
fprintf('  s > +1: 0 to right -> EVEN -> NOT on locus\n');
fprintf('  0 < s < +1: 1 pole to right -> ODD -> ON LOCUS\n');
fprintf('  -3 < s < 0: 1 pole + 1 zero = 2 to right -> EVEN -> NOT on locus\n');
fprintf('  -4 < s < -3: 2 poles + 1 pole + 1 zero = 4 to right -> EVEN -> NOT on locus\n');
fprintf('  s < -4: 4 poles + 1 zero = 5 to right -> ODD -> ON LOCUS\n\n');

fprintf('ROOT LOCUS ON REAL AXIS: [0, +1] and (-inf, -4]\n\n');

%% Step 3: Asymptotes
fprintf('STEP 3: ASYMPTOTES\n');
fprintf('------------------\n');
num_asymptotes = m - n;
fprintf('Number of asymptotes = m - n = 4 - 1 = %d\n\n', num_asymptotes);

% Asymptote angles
fprintf('Asymptote angles: phi_k = (2k+1)*180° / (m-n)\n');
phi_0 = 180 / 3;
phi_1 = 3*180 / 3;
phi_2 = 5*180 / 3;
fprintf('  phi_0 = 60°\n');
fprintf('  phi_1 = 180°\n');
fprintf('  phi_2 = 300° (or -60°)\n\n');

% Centroid
sum_poles = 1 + (-4) + (-3) + (-3);  % = -9
sum_zeros = 0;
sigma_a = (sum_poles - sum_zeros) / (m - n);
fprintf('Centroid: sigma_a = (sum poles - sum zeros) / (m-n)\n');
fprintf('  sigma_a = (1 - 4 - 3 - 3 - 0) / 3 = -9/3 = %.2f\n\n', sigma_a);

%% Step 4: Breakaway/Break-in Points
fprintf('STEP 4: BREAKAWAY/BREAK-IN POINTS\n');
fprintf('----------------------------------\n');
fprintf('Breakaway occurs on real-axis locus segments.\n');
fprintf('Segments: [0, +1] and (-inf, -4]\n\n');

% For segment [0, +1]: This is a break-in point (branches come together)
% For segment (-inf, -4]: breakaway to asymptotes

fprintf('On segment [0, +1]: Break-in point expected\n');
fprintf('On segment (-inf, -4]: Breakaway point expected\n\n');

%% Step 5: Departure Angles
fprintf('STEP 5: DEPARTURE ANGLES FROM REPEATED POLE\n');
fprintf('--------------------------------------------\n');
fprintf('At repeated pole s = -3 (multiplicity 2):\n');
fprintf('Two branches depart from this point.\n');
fprintf('Since its on real axis, branches depart at ±90° initially.\n\n');

%% Step 6: Imaginary Axis Crossings (Routh-Hurwitz)
fprintf('STEP 6: IMAGINARY AXIS CROSSINGS\n');
fprintf('---------------------------------\n');

% Characteristic equation: 1 + K*L(s) = 0
% (s-1)(s+4)(s+3)^2 + Ks = 0
% Expand denominator:
% (s-1)(s+4) = s^2 + 3s - 4
% (s^2 + 3s - 4)(s^2 + 6s + 9) = s^4 + 6s^3 + 9s^2 + 3s^3 + 18s^2 + 27s - 4s^2 - 24s - 36
% = s^4 + 9s^3 + 23s^2 + 3s - 36

fprintf('Characteristic equation:\n');
fprintf('  (s-1)(s+4)(s+3)^2 + Ks = 0\n');
fprintf('  s^4 + 9s^3 + 23s^2 + 3s - 36 + Ks = 0\n');
fprintf('  s^4 + 9s^3 + 23s^2 + (3+K)s - 36 = 0\n\n');

fprintf('Routh Array:\n');
fprintf('  s^4 |  1        23       -36\n');
fprintf('  s^3 |  9       (3+K)       0\n');
fprintf('  s^2 | b1       -36         0\n');
fprintf('  s^1 | c1         0         0\n');
fprintf('  s^0 | -36        0         0\n\n');

fprintf('Where:\n');
fprintf('  b1 = [9*23 - 1*(3+K)] / 9 = (207 - 3 - K) / 9 = (204 - K) / 9\n');
fprintf('  c1 = [b1*(3+K) - 9*(-36)] / b1 = (3+K) + 324/b1\n\n');

% For stability: need all first column positive
% s^0 row: -36 < 0 always! System cannot be stabilized!
fprintf('IMPORTANT: The s^0 row has -36, which is always NEGATIVE!\n');
fprintf('This means the system CANNOT be stabilized for any K > 0.\n\n');

% For jw crossing, we need s^1 row = 0
% c1 = 0: (3+K) + 324*9/(204-K) = 0
fprintf('For imaginary axis crossing (c1 = 0):\n');
fprintf('  (3+K) + 324*9/(204-K) = 0\n');
fprintf('  (3+K)(204-K) + 2916 = 0\n');
fprintf('  612 - 3K + 204K - K^2 + 2916 = 0\n');
fprintf('  -K^2 + 201K + 3528 = 0\n');
fprintf('  K^2 - 201K - 3528 = 0\n\n');

K_crossing = roots([1 -201 -3528]);
K_positive = K_crossing(K_crossing > 0);
fprintf('  K = %.2f (positive root)\n\n', K_positive);

% Find frequency
b1_at_K = (204 - K_positive) / 9;
fprintf('At K = %.2f:\n', K_positive);
fprintf('  b1 = (204 - %.2f) / 9 = %.4f\n', K_positive, b1_at_K);

% Auxiliary polynomial: b1*s^2 - 36 = 0
omega_sq = 36 / b1_at_K;
if omega_sq > 0
    omega_cross = sqrt(omega_sq);
    fprintf('  Auxiliary: %.4f*s^2 - 36 = 0\n', b1_at_K);
    fprintf('  s^2 = %.4f\n', omega_sq);
    fprintf('  s = ±j%.4f\n\n', omega_cross);
    fprintf('IMAGINARY AXIS CROSSING: s = ±j%.2f at K = %.2f\n\n', omega_cross, K_positive);
else
    fprintf('  No valid jw crossing (omega^2 < 0)\n\n');
end

%% ========================================================================
%% PART B: MATLAB VERIFICATION
%% ========================================================================
fprintf('=== PART B: MATLAB VERIFICATION ===\n\n');

% Define transfer function
num = [1 0];  % s
den = conv([1 -1], [1 4]);      % (s-1)(s+4)
den = conv(den, [1 6 9]);        % multiply by (s+3)^2

L = tf(num, den);
fprintf('Open-loop transfer function L(s):\n');
L

%% Plot Root Locus
figure('Name', 'Question 5.2 - Root Locus', 'Position', [100 100 1000 500]);

% Main plot
subplot(1,2,1);
rlocus(L);
title('Root Locus: L(s) = s/[(s-1)(s+4)(s+3)^2]', 'FontSize', 12);
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;
sgrid;

% Add asymptotes
hold on;
plot(sigma_a, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 2);
t = linspace(0, 15, 100);
plot(sigma_a + t*cosd(60), t*sind(60), 'g--', 'LineWidth', 1.5);
plot(sigma_a - t, zeros(size(t)), 'g--', 'LineWidth', 1.5);
plot(sigma_a + t*cosd(-60), t*sind(-60), 'g--', 'LineWidth', 1.5);
% Mark unstable region
xline(0, 'r--', 'LineWidth', 1.5);
legend('Root Locus', 'Centroid', 'Asymptotes', '', '', 'jw-axis', 'Location', 'best');
hold off;

% Zoomed view
subplot(1,2,2);
rlocus(L);
title('Root Locus (Zoomed)', 'FontSize', 12);
xlim([-10 5]);
ylim([-8 8]);
grid on;
hold on;
xline(0, 'r--', 'LineWidth', 1.5);
plot(sigma_a, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 2);
hold off;

%% Summary
fprintf('\n========================================\n');
fprintf('ROOT LOCUS SUMMARY FOR QUESTION 5.2\n');
fprintf('========================================\n');
fprintf('Open-loop poles: +1, -4, -3, -3\n');
fprintf('Open-loop zeros: 0\n');
fprintf('Number of branches: 4\n');
fprintf('Number of asymptotes: 3\n');
fprintf('Asymptote angles: 60°, 180°, 300°\n');
fprintf('Centroid: σ_a = %.2f\n', sigma_a);
fprintf('Real axis locus: [0, +1] and (-∞, -4]\n');
fprintf('jω-axis crossing: ω ≈ %.2f at K ≈ %.2f\n', omega_cross, K_positive);
fprintf('\n*** UNSTABLE SYSTEM: Cannot be stabilized! ***\n');
fprintf('   (Constant -36 term in char. eqn.)\n');
fprintf('========================================\n');

%% Save figure
saveas(gcf, 'question5_2_rootlocus.png');
fprintf('\nFigure saved as: question5_2_rootlocus.png\n');
