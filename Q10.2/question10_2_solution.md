# Question 10.2 - Pole Placement Analysis (Detailed Solution)

## Problem Statement
Consider the state-space system:
$$\dot{x} = Fx + Gu, \quad y = Hx + Ju$$

With:
$$F = \begin{bmatrix} 5 & 0 \\ 0 & 10 \end{bmatrix}, \quad G = \begin{bmatrix} 1 \\ 1 \end{bmatrix}, \quad H = \begin{bmatrix} 1 & 0 \end{bmatrix}, \quad J = 0$$

**Questions:**
- a) Can you place the poles at -5 and -5? Why?
- b) Can you place the poles at -10 and -10? Why?

---

## Step 1: Find Open-Loop Poles

Since F is diagonal, eigenvalues are the diagonal elements:

**Open-loop poles: s = +5, s = +10**

⚠️ Both poles in RHP → System is **unstable**

---

## Step 2: Check Controllability

### Controllability Matrix
$$\mathcal{C} = \begin{bmatrix} G & FG \end{bmatrix}$$

Calculate:
$$FG = \begin{bmatrix} 5 & 0 \\ 0 & 10 \end{bmatrix} \begin{bmatrix} 1 \\ 1 \end{bmatrix} = \begin{bmatrix} 5 \\ 10 \end{bmatrix}$$

$$\mathcal{C} = \begin{bmatrix} 1 & 5 \\ 1 & 10 \end{bmatrix}$$

### Determinant
$$\det(\mathcal{C}) = (1)(10) - (1)(5) = 10 - 5 = 5 \neq 0$$

**rank(C) = 2 = n → System is FULLY CONTROLLABLE!**

Since the system is fully controllable, we can place poles **anywhere** we want.

---

## Step 3: State Feedback Design

With state feedback u = -Kx where K = [k₁, k₂]:

$$F - GK = \begin{bmatrix} 5 & 0 \\ 0 & 10 \end{bmatrix} - \begin{bmatrix} 1 \\ 1 \end{bmatrix}\begin{bmatrix} k_1 & k_2 \end{bmatrix}$$

$$F - GK = \begin{bmatrix} 5-k_1 & -k_2 \\ -k_1 & 10-k_2 \end{bmatrix}$$

### Characteristic Polynomial
$$\det(sI - (F-GK)) = (s-5+k_1)(s-10+k_2) - k_1 k_2$$

Expanding:
$$= s^2 - (15-k_1-k_2)s + (5-k_1)(10-k_2) - k_1 k_2$$
$$= s^2 + (k_1+k_2-15)s + (50 - 10k_1 - 5k_2)$$

---

## Part A: Poles at -5 and -5?

**Desired poles:** -5, -5

**Desired characteristic polynomial:**
$$(s+5)^2 = s^2 + 10s + 25$$

### Match Coefficients:
| Coefficient | Equation |
|-------------|----------|
| s¹ | k₁ + k₂ - 15 = 10 → **k₁ + k₂ = 25** |
| s⁰ | 50 - 10k₁ - 5k₂ = 25 → **2k₁ + k₂ = 5** |

### Solve:
From (1): k₂ = 25 - k₁
Substitute into (2): 2k₁ + (25 - k₁) = 5
→ k₁ = -20
→ k₂ = 25 - (-20) = 45

**K = [-20, 45]**

### Verification:
$$F - GK = \begin{bmatrix} 5-(-20) & -45 \\ -(-20) & 10-45 \end{bmatrix} = \begin{bmatrix} 25 & -45 \\ 20 & -35 \end{bmatrix}$$

Eigenvalues: -5, -5 ✓

### Answer A:
$$\boxed{\text{YES - K = [-20, 45] places poles at -5, -5}}$$

**Why:** The system is fully controllable (det(C) ≠ 0), so arbitrary pole placement is possible.

---

## Part B: Poles at -10 and -10?

**Desired poles:** -10, -10

**Desired characteristic polynomial:**
$$(s+10)^2 = s^2 + 20s + 100$$

### Match Coefficients:
| Coefficient | Equation |
|-------------|----------|
| s¹ | k₁ + k₂ - 15 = 20 → **k₁ + k₂ = 35** |
| s⁰ | 50 - 10k₁ - 5k₂ = 100 → **2k₁ + k₂ = -10** |

### Solve:
From (1): k₂ = 35 - k₁
Substitute into (2): 2k₁ + (35 - k₁) = -10
→ k₁ = -45
→ k₂ = 35 - (-45) = 80

**K = [-45, 80]**

### Verification:
$$F - GK = \begin{bmatrix} 50 & -80 \\ 45 & -70 \end{bmatrix}$$

Eigenvalues: -10, -10 ✓

### Answer B:
$$\boxed{\text{YES - K = [-45, 80] places poles at -10, -10}}$$

**Why:** The system is fully controllable, so we can place poles anywhere, including at -10, -10.

---

## Comparison with Question 10.1

| Aspect | Q10.1 | Q10.2 |
|--------|-------|-------|
| F matrix | [1,1; 0,-1] | [5,0; 0,10] |
| G vector | [1; 0] | [1; 1] |
| det(C) | 0 | 5 |
| Controllable? | Partially | **Fully** |
| Poles at -5,-5? | N/A | ✅ YES |
| Poles at -10,-10? | N/A | ✅ YES |

**Key Difference:** In Q10.2, both states are affected by input u (G = [1; 1]), making the system fully controllable.

---

## Summary

| Question | Desired Poles | Possible? | K |
|----------|--------------|-----------|---|
| a) | -5, -5 | ✅ YES | [-20, 45] |
| b) | -10, -10 | ✅ YES | [-45, 80] |

**Both possible because system is FULLY CONTROLLABLE (rank(C) = n = 2)**
