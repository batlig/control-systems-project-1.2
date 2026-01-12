%% MCH 3008 Control Systems - Project 1.2
%% Question 6.1: PID-Lead Controller (Pole-Zero Cancellation)
% G(s) = 1 / [(s+4)(s+6)]
% Specifications: tr < 0.18s, Mp < 20%, ess < 0.01
%
% STRATEGY: Pole-Zero Cancellation
% We cancel the plant poles (-4, -6) with controller zeros.
% System becomes pure 2nd order: K / [s(s+p)]
% This ensures exact matching of transient specs and ess=0.

clear; clc; close all;

fprintf('=== QUESTION 6.1: CONTROLLER DESIGN (OPTIMIZED) ===\n\n');

%% Design Specs
tr_spec = 0.18;
Mp_spec = 0.20;
ess_spec = 0.01;

%% Step 1: 2nd Order System Parameters
% Target pure 2nd order system: T(s) = wn^2 / (s^2 + 2*zeta*wn*s + wn^2)
% Mp < 20% -> zeta >= 0.456. Let's use zeta = 0.6 (Mp ~ 9.5%)
zeta = 0.6;

% tr < 0.18s. For zeta=0.6, tr ≈ 2.2/wn.
% wn > 2.2/0.18 = 12.2. Let's use wn = 15 rad/s.
wn = 15;

fprintf('Selected parameters:\n');
fprintf('  zeta = %.2f\n', zeta);
fprintf('  wn = %.1f rad/s\n\n', wn);

%% Step 2: Controller Synthesis
% Plant G(s) = 1 / [(s+4)(s+6)]
% Proposed Controller C(s) = K * (s+4)(s+6) / [s(s+p)]
% Open Loop L(s) = K / [s(s+p)]
% Closed Loop Char Eq: s(s+p) + K = s^2 + p*s + K = 0
% Compare with s^2 + 2*zeta*wn*s + wn^2 = 0

K = wn^2;
p = 2 * zeta * wn;

fprintf('Controller parameters:\n');
fprintf('  K = %.2f\n', K);
fprintf('  p = %.2f\n', p);

C = tf(K * poly([-4 -6]), [1 p 0]);
fprintf('\nController C(s):\n');
C

%% Verification
G = tf(1, poly([-4 -6]));
L = C * G;
T = feedback(L, 1);
info = stepinfo(T);
ess = abs(1 - dcgain(T));

fprintf('\nVERIFICATION:\n');
fprintf('  tr: %.4f s (spec < 0.18)\n', info.RiseTime);
fprintf('  Mp: %.2f%% (spec < 20%%)\n', info.Overshoot);
fprintf('  ess: %.6f (spec < 0.01)\n', ess);

%% Simulations for Report
figure('Name', 'Q6.1 Final Solution');
subplot(1,2,1);
step(T);
title('Step Response');
grid on;

subplot(1,2,2);
rlocus(L);
title('Root Locus');
grid on;

%% Bode Diagram (Parts c & d)
figure('Name', 'Q6.1 Bode Diagram');
bode(L);
grid on;
title('Bode Diagram of C(s)G(s)');
margin(L);
saveas(gcf, 'question6_1_bode.png');

saveas(1, 'question6_1_solution.png');
