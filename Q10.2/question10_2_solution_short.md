# Question 10.2 - Solution (Short)

**F = [5,0; 0,10], G = [1; 1]**

---

## Step 1: Open-Loop Poles
Diagonal F → eigenvalues = **+5, +10** (both unstable)

---

## Step 2: Controllability

$$\mathcal{C} = [G \;|\; FG] = \begin{bmatrix} 1 & 5 \\ 1 & 10 \end{bmatrix}$$

**det(C) = 10 - 5 = 5 ≠ 0** → FULLY CONTROLLABLE!

---

## Step 3: Characteristic Polynomial

With K = [k₁, k₂]:
$$\det(sI - F + GK) = s^2 + (k_1+k_2-15)s + (50-10k_1-5k_2)$$

---

## Part A: Poles at -5, -5?

Desired: (s+5)² = s² + 10s + 25

Match coefficients:
- k₁ + k₂ = 25
- 2k₁ + k₂ = 5

Solve: **k₁ = -20, k₂ = 45**

$$\boxed{\text{YES, K = [-20, 45]}}$$

---

## Part B: Poles at -10, -10?

Desired: (s+10)² = s² + 20s + 100

Match coefficients:
- k₁ + k₂ = 35
- 2k₁ + k₂ = -10

Solve: **k₁ = -45, k₂ = 80**

$$\boxed{\text{YES, K = [-45, 80]}}$$

---

## Summary

| Poles | Possible? | K | Why |
|-------|-----------|---|-----|
| -5, -5 | ✅ YES | [-20, 45] | Fully controllable |
| -10, -10 | ✅ YES | [-45, 80] | Fully controllable |

**Both work because det(C) ≠ 0!**
