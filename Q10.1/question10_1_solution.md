# Question 10.1 - Pole Placement Analysis (Detailed Solution)

## Problem Statement
Consider the state-space system:
$$\dot{x} = Fx + Gu, \quad y = Hx + Ju$$

With:
$$F = \begin{bmatrix} 1 & 1 \\ 0 & -1 \end{bmatrix}, \quad G = \begin{bmatrix} 1 \\ 0 \end{bmatrix}, \quad H = \begin{bmatrix} 1 & 0 \end{bmatrix}, \quad J = 0$$

**Questions:**
- a) Can you place the poles at -1 and -1? Why?
- b) Can you place the poles at -2 and -2? Why?

---

## Step 1: Find Open-Loop Poles

Eigenvalues of F:
$$\det(sI - F) = \det\begin{bmatrix} s-1 & -1 \\ 0 & s+1 \end{bmatrix} = (s-1)(s+1) = 0$$

**Open-loop poles: s = +1, s = -1**

⚠️ The system is **unstable** (pole at s = +1)

---

## Step 2: Check Controllability

### Controllability Matrix
$$\mathcal{C} = \begin{bmatrix} G & FG \end{bmatrix}$$

Calculate FG:
$$FG = \begin{bmatrix} 1 & 1 \\ 0 & -1 \end{bmatrix} \begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$$

So:
$$\mathcal{C} = \begin{bmatrix} 1 & 1 \\ 0 & 0 \end{bmatrix}$$

### Rank Analysis
$$\text{rank}(\mathcal{C}) = 1 \neq 2$$

Wait - let me recalculate. Actually:
$$\mathcal{C} = \begin{bmatrix} 1 & 1 \\ 0 & 0 \end{bmatrix}$$

The rank is **1**, not 2! The second row is all zeros.

### What This Means
- The system is **NOT completely controllable**
- State x₂ cannot be controlled by input u
- Looking at the state equations:
  - ẋ₁ = x₁ + x₂ + u (controllable)
  - ẋ₂ = -x₂ (NOT controllable - no u term!)

The pole at **s = -1** (from x₂ dynamics) is **uncontrollable**!

---

## Step 3: Closed-Loop Analysis with State Feedback

With state feedback u = -Kx where K = [k₁, k₂]:
$$\dot{x} = (F - GK)x = \begin{bmatrix} 1-k_1 & 1-k_2 \\ 0 & -1 \end{bmatrix}x$$

### Closed-Loop Eigenvalues
The matrix F - GK is **upper triangular**, so eigenvalues are the diagonal elements:
- **λ₁ = 1 - k₁** (can be controlled by choosing k₁)
- **λ₂ = -1** (FIXED - cannot change!)

No matter what K we choose, **one pole is always at s = -1**.

---

## Part A: Poles at -1 and -1?

**Desired poles:** -1, -1

### Analysis:
- Uncontrollable pole is already at **s = -1** ✓
- Need to move controllable pole from +1 to -1
- Set: 1 - k₁ = -1 → **k₁ = 2**
- k₂ can be anything (doesn't affect eigenvalues)

### Solution:
$$K = \begin{bmatrix} 2 & 0 \end{bmatrix}$$

Verification:
$$F - GK = \begin{bmatrix} 1-2 & 1-0 \\ 0 & -1 \end{bmatrix} = \begin{bmatrix} -1 & 1 \\ 0 & -1 \end{bmatrix}$$

Eigenvalues: -1, -1 ✓

### Answer A:
$$\boxed{\text{YES - K = [2, 0] places poles at -1, -1}}$$

**Why:** The uncontrollable pole is already at -1, and we can move the controllable pole from +1 to -1 by choosing k₁ = 2.

---

## Part B: Poles at -2 and -2?

**Desired poles:** -2, -2

### Analysis:
- Uncontrollable pole is FIXED at **s = -1**
- We CANNOT move it to s = -2
- For any K = [k₁, k₂], one eigenvalue is always -1

### Verification:
Even if we try k₁ = 3 (to get 1 - k₁ = -2):
$$F - GK = \begin{bmatrix} -2 & 1-k_2 \\ 0 & -1 \end{bmatrix}$$

Eigenvalues: **-2, -1** (NOT -2, -2!)

### Answer B:
$$\boxed{\text{NO - Cannot place both poles at -2}}$$

**Why:** The pole at s = -1 is uncontrollable (corresponds to the autonomous dynamics of x₂) and cannot be moved by any state feedback.

---

## Summary

| Question | Desired Poles | Possible? | Why |
|----------|--------------|-----------|-----|
| a) | -1, -1 | ✅ YES | Uncontrollable pole already at -1 |
| b) | -2, -2 | ❌ NO | Cannot move uncontrollable pole |

### Key Insight:
Even though the controllability matrix has rank 1 < n = 2, we can still do **partial pole placement**. We can move the controllable pole anywhere, but the uncontrollable pole at s = -1 stays fixed.
