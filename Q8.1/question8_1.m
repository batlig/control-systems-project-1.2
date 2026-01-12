%% MCH 3008 Control Systems - Project 1.2
%% Question 8.1: Nyquist Diagram and Stability Analysis
% G(s) = (s^2 + 1) / [s(s^2 + 2s + 3)]
%
% Tasks:
% - Plot Nyquist diagram
% - Determine if closed-loop system is stable

clear; clc; close all;

%% ========================================================================
%% SYSTEM ANALYSIS
%% ========================================================================
fprintf('=== QUESTION 8.1: NYQUIST DIAGRAM ===\n\n');

%% Define the transfer function
num = [1 0 1];           % s^2 + 1
den = conv([1 0], [1 2 3]);  % s * (s^2 + 2s + 3)

G = tf(num, den);
fprintf('Open-loop transfer function G(s):\n');
G

%% Analyze poles and zeros
fprintf('=== POLE-ZERO ANALYSIS ===\n\n');

poles_G = pole(G);
zeros_G = zero(G);

fprintf('Open-loop POLES:\n');
for i = 1:length(poles_G)
    if imag(poles_G(i)) >= 0 || imag(poles_G(i)) == 0
        fprintf('  p%d = %.4f + j%.4f\n', i, real(poles_G(i)), imag(poles_G(i)));
    end
end

fprintf('\nOpen-loop ZEROS:\n');
for i = 1:length(zeros_G)
    if imag(zeros_G(i)) >= 0
        fprintf('  z%d = %.4f + j%.4f\n', i, real(zeros_G(i)), imag(zeros_G(i)));
    end
end

% Count RHP poles (P)
P = sum(real(poles_G) > 0);
fprintf('\nNumber of RHP poles (P) = %d\n', P);

% Check for poles on imaginary axis
poles_on_jw = sum(abs(real(poles_G)) < 1e-6);
fprintf('Poles on jw-axis: %d (at s = 0)\n\n', poles_on_jw);

%% ========================================================================
%% NYQUIST CRITERION ANALYSIS
%% ========================================================================
fprintf('=== NYQUIST STABILITY CRITERION ===\n\n');

fprintf('The Nyquist criterion states:\n');
fprintf('  Z = N + P\n');
fprintf('where:\n');
fprintf('  Z = number of closed-loop RHP poles (unstable)\n');
fprintf('  N = number of clockwise encirclements of -1\n');
fprintf('  P = number of open-loop RHP poles = %d\n\n', P);

fprintf('For STABILITY: Z = 0, so we need N = -P = %d\n', -P);
fprintf('(Negative N means counter-clockwise encirclements)\n\n');

%% ========================================================================
%% HANDLE POLE AT ORIGIN
%% ========================================================================
fprintf('=== HANDLING POLE AT s = 0 ===\n\n');

fprintf('Since G(s) has a pole at s = 0, we must indent around it.\n');
fprintf('As we go around a small semicircle s = ε*e^(jθ), θ: -90° to +90°,\n');
fprintf('G(s) traces an arc of radius |G| → ∞ from angle +90° to -90°.\n\n');

% Behavior near s = 0
% G(s) ≈ (1)/(s*3) = 1/(3s) as s → 0
% So |G| → ∞ and angle = -90° (for s on positive imaginary axis)
fprintf('Near s = 0: G(s) ≈ 1/(3s)\n');
fprintf('This creates a large semicircular arc at infinity.\n\n');

%% ========================================================================
%% CALCULATE KEY POINTS ON NYQUIST PLOT
%% ========================================================================
fprintf('=== KEY POINTS ON NYQUIST PLOT ===\n\n');

% G(jω) for various frequencies
omega_test = [0.01, 0.5, 1, sqrt(3), 2, 5, 10, 100];
fprintf('ω (rad/s)     |G(jω)|        ∠G(jω) (deg)\n');
fprintf('------------------------------------------------\n');

for w = omega_test
    G_jw = evalfr(G, 1j*w);
    fprintf('  %6.2f      %8.4f      %8.2f°\n', w, abs(G_jw), angle(G_jw)*180/pi);
end
fprintf('\n');

% Special point: ω → ∞
fprintf('As ω → ∞: G(jω) → 0 at angle -90°\n');
fprintf('As ω → 0+: G(jω) → ∞ at angle -90°\n\n');

% Check if Nyquist plot crosses negative real axis
fprintf('Checking for real-axis crossings:\n');
% G(jω) is real when Im(G(jω)) = 0
% G(jω) = (1-ω²) / [jω(3 - ω² + 2jω)]
%       = (1-ω²) / [jω(3-ω²) - 2ω²]
%       = (1-ω²) / [-2ω² + jω(3-ω²)]

% Multiply by conjugate:
% G(jω) = (1-ω²)[-2ω² - jω(3-ω²)] / [4ω⁴ + ω²(3-ω²)²]

% Imaginary part = 0 when:
% -(1-ω²)ω(3-ω²) = 0
% Solutions: ω = 1 or ω = √3

fprintf('  Im(G(jω)) = 0 at ω = 1 and ω = √3\n\n');

% Calculate G at these frequencies
G_at_1 = evalfr(G, 1j*1);
G_at_sqrt3 = evalfr(G, 1j*sqrt(3));

fprintf('At ω = 1:    G(j) = %.4f (real)\n', real(G_at_1));
fprintf('At ω = √3:   G(j√3) = %.4f (real)\n\n', real(G_at_sqrt3));

%% ========================================================================
%% DETERMINE STABILITY
%% ========================================================================
fprintf('=== STABILITY ANALYSIS ===\n\n');

% Check encirclements of -1
fprintf('From the Nyquist plot:\n');
fprintf('  - G(j1) = %.4f (does not encircle -1)\n', real(G_at_1));
fprintf('  - G(j√3) = %.4f (to the right of -1)\n\n', real(G_at_sqrt3));

% The Nyquist contour:
% 1. Starts at ω=0+: G = ∞ at -90°
% 2. As ω increases: traces upper part of plot
% 3. Crosses real axis at G(j1) = 0 and G(j√3) = -0.167
% 4. As ω → ∞: G → 0 at -90°
% 5. Mirror image for ω < 0

fprintf('The Nyquist plot does NOT encircle the point -1.\n');
fprintf('Number of encirclements N = 0\n\n');

fprintf('Applying Nyquist criterion:\n');
fprintf('  Z = N + P = 0 + 0 = 0\n\n');
fprintf('Since Z = 0, the closed-loop system has NO RHP poles.\n');
fprintf('*** CLOSED-LOOP SYSTEM IS STABLE ***\n\n');

%% ========================================================================
%% PLOT NYQUIST DIAGRAM
%% ========================================================================
figure('Name', 'Question 8.1 - Nyquist Diagram', 'Position', [100 100 1000 500]);

% Standard Nyquist plot
subplot(1,2,1);
nyquist(G);
title('Nyquist Diagram of G(s)', 'FontSize', 12);
grid on;
hold on;
plot(-1, 0, 'r+', 'MarkerSize', 15, 'LineWidth', 2);  % Mark -1 point
legend('Nyquist Plot', 'Critical Point (-1,0)', 'Location', 'best');
hold off;

% Zoomed view near origin
subplot(1,2,2);
nyquist(G);
title('Nyquist Diagram (Zoomed)', 'FontSize', 12);
xlim([-2 1]);
ylim([-2 2]);
grid on;
hold on;
plot(-1, 0, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
hold off;

%% Alternative: Manual frequency response plot
figure('Name', 'Question 8.1 - Frequency Response', 'Position', [100 100 600 500]);

w = logspace(-2, 2, 1000);
[re, im] = nyquist(G, w);
re = squeeze(re);
im = squeeze(im);

plot(re, im, 'b-', 'LineWidth', 1.5);
hold on;
plot(re, -im, 'b--', 'LineWidth', 1.5);  % Mirror for negative frequencies
plot(-1, 0, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
xlabel('Real');
ylabel('Imaginary');
title('Nyquist Plot of G(s) = (s²+1)/[s(s²+2s+3)]', 'FontSize', 12);
grid on;
axis equal;
xlim([-1.5 0.5]);
ylim([-2 2]);
legend('ω > 0', 'ω < 0', '-1 Point', 'Location', 'best');
hold off;

%% Save figures
saveas(1, 'question8_1_nyquist.png');
saveas(2, 'question8_1_nyquist_detail.png');
fprintf('Figures saved!\n');

%% Summary
fprintf('\n========================================\n');
fprintf('QUESTION 8.1 SUMMARY\n');
fprintf('========================================\n');
fprintf('G(s) = (s²+1) / [s(s²+2s+3)]\n\n');
fprintf('Open-loop poles: 0, -1±j√2\n');
fprintf('Open-loop zeros: ±j\n');
fprintf('RHP poles (P): 0\n');
fprintf('Encirclements of -1 (N): 0\n');
fprintf('Closed-loop RHP poles (Z): N + P = 0\n');
fprintf('\nCONCLUSION: Closed-loop is STABLE\n');
fprintf('========================================\n');
