%% MCH 3008 Control Systems - Project 1.2
%% Question 10.1: Pole Placement Analysis
%
% State-space system:
% x_dot = Fx + Gu
% y = Hx + Ju
%
% F = [1, 1; 0, -1], G = [1; 0], H = [1, 0], J = 0
%
% Questions:
% a) Can you place poles at -1 and -1? Why?
% b) Can you place poles at -2 and -2? Why?

clear; clc; close all;

%% ========================================================================
%% SYSTEM DEFINITION
%% ========================================================================
fprintf('=== QUESTION 10.1: POLE PLACEMENT ANALYSIS ===\n\n');

F = [1 1; 0 -1];
G = [1; 0];
H = [1 0];
J = 0;

fprintf('State-space system:\n');
fprintf('  F = [1, 1; 0, -1]\n');
fprintf('  G = [1; 0]\n');
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

% Note: One pole at +1 (unstable!), one at -1
fprintf('Note: The open-loop system is UNSTABLE (pole at s = +1)\n\n');

%% ========================================================================
%% STEP 2: CHECK CONTROLLABILITY
%% ========================================================================
fprintf('=== STEP 2: CONTROLLABILITY CHECK ===\n\n');

% Controllability matrix: C = [G, FG]
C_matrix = [G, F*G];
fprintf('Controllability matrix:\n');
fprintf('  C = [G | FG] = [%d %d; %d %d]\n', C_matrix(1,1), C_matrix(1,2), C_matrix(2,1), C_matrix(2,2));

rank_C = rank(C_matrix);
n = size(F, 1);  % System order

fprintf('\nRank of C = %d\n', rank_C);
fprintf('System order n = %d\n\n', n);

if rank_C == n
    fprintf('Rank(C) = n → System is CONTROLLABLE\n');
    fprintf('Arbitrary pole placement IS possible!\n\n');
else
    fprintf('Rank(C) < n → System is NOT CONTROLLABLE\n');
    fprintf('Arbitrary pole placement is NOT possible.\n\n');
end

%% ========================================================================
%% STEP 3: ANALYZE POLE PLACEMENT LIMITATIONS
%% ========================================================================
fprintf('=== STEP 3: UNDERSTANDING THE LIMITATION ===\n\n');

fprintf('Even though rank(C) = 2 = n, there is a subtle issue...\n\n');

% The controllability matrix
fprintf('C = [1  1]\n');
fprintf('    [0  0]\n\n');

fprintf('The second row is all zeros!\n');
fprintf('This means x2 is NOT directly controllable.\n\n');

% Let's look at the system structure
fprintf('System equations:\n');
fprintf('  x1_dot = x1 + x2 + u\n');
fprintf('  x2_dot = -x2\n\n');

fprintf('Notice: x2_dot = -x2 has NO input u!\n');
fprintf('→ x2 has its own dynamics independent of control.\n');
fprintf('→ x2 always decays with pole at s = -1.\n\n');

fprintf('The pole at s = -1 is UNCONTROLLABLE (fixed)!\n');
fprintf('Only the pole at s = +1 can be moved.\n\n');

%% ========================================================================
%% PART A: CAN WE PLACE POLES AT -1 AND -1?
%% ========================================================================
fprintf('=== PART A: POLES AT -1 AND -1? ===\n\n');

desired_poles_a = [-1, -1];

fprintf('Desired poles: -1, -1\n\n');

% The uncontrollable pole is already at -1
fprintf('Analysis:\n');
fprintf('  - Uncontrollable pole is fixed at s = -1 ✓\n');
fprintf('  - We need to move the controllable pole from +1 to -1\n\n');

% Find the feedback gain
% Closed-loop: det(sI - F + GK) should have roots at -1, -1
% With K = [k1, k2], the closed-loop matrix is F - GK
% F - GK = [1-k1, 1-k2; 0, -1]
% 
% Characteristic polynomial: (s - (1-k1))(s + 1) = 0
% For pole at -1: 1 - k1 = -1 → k1 = 2

fprintf('Finding feedback gain K = [k1, k2]:\n');
fprintf('  Closed-loop matrix: F - GK = [1-k1, 1-k2; 0, -1]\n');
fprintf('  Characteristic poly: (s-(1-k1))(s+1) = 0\n\n');
fprintf('  For pole at -1: 1 - k1 = -1 → k1 = 2\n');
fprintf('  k2 can be anything (doesnt affect poles)\n\n');

K_a = [2 0];  % k2 = 0 for simplicity
F_cl_a = F - G*K_a;
poles_cl_a = eig(F_cl_a);

fprintf('Using K = [2, 0]:\n');
fprintf('  Closed-loop poles: %.2f, %.2f\n\n', poles_cl_a(1), poles_cl_a(2));

fprintf('*** ANSWER A: YES, we CAN place poles at -1, -1 ***\n');
fprintf('   K = [2, 0] achieves this.\n\n');

%% ========================================================================
%% PART B: CAN WE PLACE POLES AT -2 AND -2?
%% ========================================================================
fprintf('=== PART B: POLES AT -2 AND -2? ===\n\n');

desired_poles_b = [-2, -2];

fprintf('Desired poles: -2, -2\n\n');

fprintf('Analysis:\n');
fprintf('  - Uncontrollable pole is FIXED at s = -1\n');
fprintf('  - We CANNOT move it to s = -2!\n');
fprintf('  - No matter what K we choose, one pole stays at -1\n\n');

% Try anyway
fprintf('Lets verify. For any K = [k1, k2]:\n');
fprintf('  F - GK = [1-k1, 1-k2; 0, -1]\n');
fprintf('  Eigenvalues: (1-k1) and -1\n\n');
fprintf('  The eigenvalue -1 is ALWAYS present!\n\n');

% Try to use acker (it will fail or give wrong result)
try
    K_b = acker(F, G, desired_poles_b);
    F_cl_b = F - G*K_b;
    poles_cl_b = eig(F_cl_b);
    fprintf('MATLAB acker gives K = [%.4f, %.4f]\n', K_b(1), K_b(2));
    fprintf('Actual closed-loop poles: %.4f, %.4f\n', poles_cl_b(1), poles_cl_b(2));
    fprintf('(Note: Still has pole at -1, not -2!)\n\n');
catch
    fprintf('acker function cannot achieve this placement.\n\n');
end

fprintf('*** ANSWER B: NO, we CANNOT place poles at -2, -2 ***\n');
fprintf('   The pole at s = -1 is uncontrollable and cannot be moved.\n\n');

%% ========================================================================
%% SUMMARY
%% ========================================================================
fprintf('========================================\n');
fprintf('QUESTION 10.1 SUMMARY\n');
fprintf('========================================\n');
fprintf('System: F = [1,1; 0,-1], G = [1; 0]\n\n');
fprintf('Open-loop poles: +1 (unstable), -1\n');
fprintf('Controllability matrix rank = 2 (full rank)\n');
fprintf('BUT: pole at -1 is uncontrollable!\n\n');
fprintf('a) Poles at -1, -1: YES ✓ (K = [2, 0])\n');
fprintf('b) Poles at -2, -2: NO ✗ (cant move -1 pole)\n');
fprintf('========================================\n');
