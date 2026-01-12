%% MCH 3008 Control Systems - Project 1.2
%% Question 10.2: Pole Placement Analysis
%
% State-space system:
% x_dot = Fx + Gu
% y = Hx + Ju
%
% F = [5, 0; 0, 10], G = [1; 1], H = [1, 0], J = 0
%
% Questions:
% a) Can you place poles at -5 and -5? Why?
% b) Can you place poles at -10 and -10? Why?

clear; clc; close all;

%% ========================================================================
%% SYSTEM DEFINITION
%% ========================================================================
fprintf('=== QUESTION 10.2: POLE PLACEMENT ANALYSIS ===\n\n');

F = [5 0; 0 10];
G = [1; 1];
H = [1 0];
J = 0;

fprintf('State-space system:\n');
fprintf('  F = [5, 0; 0, 10]\n');
fprintf('  G = [1; 1]\n');
fprintf('  H = [1, 0]\n');
fprintf('  J = 0\n\n');

%% ========================================================================
%% STEP 1: FIND OPEN-LOOP POLES
%% ========================================================================
fprintf('=== STEP 1: OPEN-LOOP POLES ===\n\n');

poles_OL = eig(F);
fprintf('Open-loop poles (eigenvalues of F):\n');
fprintf('  p1 = %.2f\n', poles_OL(1));
fprintf('  p2 = %.2f\n\n', poles_OL(2));

fprintf('Both poles are in RHP → System is UNSTABLE\n\n');

%% ========================================================================
%% STEP 2: CHECK CONTROLLABILITY
%% ========================================================================
fprintf('=== STEP 2: CONTROLLABILITY CHECK ===\n\n');

% Controllability matrix: C = [G, FG]
FG = F * G;
C_matrix = [G, FG];

fprintf('Controllability matrix:\n');
fprintf('  G = [%d; %d]\n', G(1), G(2));
fprintf('  FG = [%d; %d]\n', FG(1), FG(2));
fprintf('  C = [G | FG] = [%d %d; %d %d]\n', C_matrix(1,1), C_matrix(1,2), C_matrix(2,1), C_matrix(2,2));

rank_C = rank(C_matrix);
det_C = det(C_matrix);
n = size(F, 1);

fprintf('\ndet(C) = %d\n', det_C);
fprintf('rank(C) = %d\n', rank_C);
fprintf('System order n = %d\n\n', n);

if rank_C == n
    fprintf('rank(C) = n → System is FULLY CONTROLLABLE!\n');
    fprintf('Arbitrary pole placement IS possible!\n\n');
else
    fprintf('rank(C) < n → System is NOT fully controllable.\n\n');
end

%% ========================================================================
%% STEP 3: POLE PLACEMENT ANALYSIS
%% ========================================================================
fprintf('=== STEP 3: STATE FEEDBACK DESIGN ===\n\n');

% With K = [k1, k2], closed-loop matrix is F - GK
fprintf('With state feedback u = -Kx, K = [k1, k2]:\n\n');
fprintf('F - GK = [5, 0; 0, 10] - [1; 1]*[k1, k2]\n');
fprintf('      = [5, 0; 0, 10] - [k1, k2; k1, k2]\n');
fprintf('      = [5-k1, -k2; -k1, 10-k2]\n\n');

% Characteristic polynomial
fprintf('Characteristic polynomial:\n');
fprintf('  det(sI - (F-GK)) = det([s-5+k1, k2; k1, s-10+k2])\n');
fprintf('  = (s-5+k1)(s-10+k2) - k1*k2\n');
fprintf('  = s^2 + (k1+k2-15)s + (5-k1)(10-k2) - k1*k2\n');
fprintf('  = s^2 + (k1+k2-15)s + (50 - 5k2 - 10k1 + k1*k2 - k1*k2)\n');
fprintf('  = s^2 + (k1+k2-15)s + (50 - 5k2 - 10k1)\n\n');

%% ========================================================================
%% PART A: CAN WE PLACE POLES AT -5 AND -5?
%% ========================================================================
fprintf('=== PART A: POLES AT -5 AND -5? ===\n\n');

desired_poles_a = [-5, -5];

fprintf('Desired poles: -5, -5\n');
fprintf('Desired characteristic polynomial: (s+5)^2 = s^2 + 10s + 25\n\n');

% Match coefficients:
% s^1: k1 + k2 - 15 = 10 → k1 + k2 = 25
% s^0: 50 - 5k2 - 10k1 = 25 → 5k2 + 10k1 = 25 → k2 + 2k1 = 5

fprintf('Matching coefficients:\n');
fprintf('  s^1: k1 + k2 = 25\n');
fprintf('  s^0: 2k1 + k2 = 5\n\n');

% Solve: k1 + k2 = 25, 2k1 + k2 = 5
% Subtract: k1 = -20
% Then: k2 = 25 - (-20) = 45
k1_a = -20;
k2_a = 45;
K_a = [k1_a, k2_a];

fprintf('Solution: k1 = %.0f, k2 = %.0f\n', k1_a, k2_a);
fprintf('K = [%.0f, %.0f]\n\n', k1_a, k2_a);

% Verify
F_cl_a = F - G*K_a;
poles_cl_a = eig(F_cl_a);

fprintf('Verification:\n');
fprintf('  F - GK = [%.0f, %.0f; %.0f, %.0f]\n', F_cl_a(1,1), F_cl_a(1,2), F_cl_a(2,1), F_cl_a(2,2));
fprintf('  Closed-loop poles: %.2f, %.2f\n\n', poles_cl_a(1), poles_cl_a(2));

% Also verify with MATLAB acker
K_acker_a = acker(F, G, desired_poles_a);
fprintf('MATLAB acker result: K = [%.4f, %.4f]\n\n', K_acker_a(1), K_acker_a(2));

fprintf('*** ANSWER A: YES, we CAN place poles at -5, -5 ***\n');
fprintf('   K = [%.0f, %.0f]\n\n', k1_a, k2_a);

%% ========================================================================
%% PART B: CAN WE PLACE POLES AT -10 AND -10?
%% ========================================================================
fprintf('=== PART B: POLES AT -10 AND -10? ===\n\n');

desired_poles_b = [-10, -10];

fprintf('Desired poles: -10, -10\n');
fprintf('Desired characteristic polynomial: (s+10)^2 = s^2 + 20s + 100\n\n');

% Match coefficients:
% s^1: k1 + k2 - 15 = 20 → k1 + k2 = 35
% s^0: 50 - 5k2 - 10k1 = 100 → 5k2 + 10k1 = -50 → k2 + 2k1 = -10

fprintf('Matching coefficients:\n');
fprintf('  s^1: k1 + k2 = 35\n');
fprintf('  s^0: 2k1 + k2 = -10\n\n');

% Solve: k1 + k2 = 35, 2k1 + k2 = -10
% Subtract: k1 = -45
% Then: k2 = 35 - (-45) = 80
k1_b = -45;
k2_b = 80;
K_b = [k1_b, k2_b];

fprintf('Solution: k1 = %.0f, k2 = %.0f\n', k1_b, k2_b);
fprintf('K = [%.0f, %.0f]\n\n', k1_b, k2_b);

% Verify
F_cl_b = F - G*K_b;
poles_cl_b = eig(F_cl_b);

fprintf('Verification:\n');
fprintf('  F - GK = [%.0f, %.0f; %.0f, %.0f]\n', F_cl_b(1,1), F_cl_b(1,2), F_cl_b(2,1), F_cl_b(2,2));
fprintf('  Closed-loop poles: %.2f, %.2f\n\n', poles_cl_b(1), poles_cl_b(2));

% Also verify with MATLAB acker
K_acker_b = acker(F, G, desired_poles_b);
fprintf('MATLAB acker result: K = [%.4f, %.4f]\n\n', K_acker_b(1), K_acker_b(2));

fprintf('*** ANSWER B: YES, we CAN place poles at -10, -10 ***\n');
fprintf('   K = [%.0f, %.0f]\n\n', k1_b, k2_b);

%% ========================================================================
%% SUMMARY & DYNAMIC VERIFICATION
%% ========================================================================
fprintf('========================================\n');
fprintf('QUESTION 10.2 SUMMARY & VERIFICATION\n');
fprintf('========================================\n');
fprintf('System: F = [5,0; 0,10], G = [1; 1]\n');
if rank(C_matrix) == n
    fprintf('Controllability: FULLY CONTROLLABLE (Rank = %d)\n\n', rank(C_matrix));
else
    fprintf('Controllability: NOT FULLY CONTROLLABLE\n\n');
end

% Part A Check
fprintf('a) Poles at -5, -5:\n');
poles_A = eig(F - G*K_a);
error_A = norm(sort(poles_A) - sort([-5; -5]));
if error_A < 1e-4
    fprintf('   Status: VERIFIED ✅ (Error = %.2e)\n', error_A);
    fprintf('   K = [%.4f, %.4f]\n', K_a(1), K_a(2));
else
    fprintf('   Status: FAILED ❌\n');
end

% Part B Check
fprintf('\nb) Poles at -10, -10:\n');
poles_B = eig(F - G*K_b);
error_B = norm(sort(poles_B) - sort([-10; -10]));
if error_B < 1e-4
    fprintf('   Status: VERIFIED ✅ (Error = %.2e)\n', error_B);
    fprintf('   K = [%.4f, %.4f]\n', K_b(1), K_b(2));
else
    fprintf('   Status: FAILED ❌\n');
end

fprintf('========================================\n');
