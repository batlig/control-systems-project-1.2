# Question 10.1 - Solution (Short)

**F = [1,1; 0,-1], G = [1; 0]**

---

## Step 1: Open-Loop Poles
Eigenvalues of F: **s = +1, s = -1**

---

## Step 2: Controllability
$$\mathcal{C} = [G \;|\; FG] = \begin{bmatrix} 1 & 1 \\ 0 & 0 \end{bmatrix}$$

**rank(C) = 1 < 2** → NOT fully controllable!

Looking at system:
- ẋ₁ = x₁ + x₂ + **u** ← controllable
- ẋ₂ = -x₂ ← **no u!** (uncontrollable)

**Pole at s = -1 is FIXED!**

---

## Step 3: Closed-Loop with K = [k₁, k₂]

$$F - GK = \begin{bmatrix} 1-k_1 & 1-k_2 \\ 0 & -1 \end{bmatrix}$$

Eigenvalues: **(1-k₁)** and **-1** (always!)

---

## Part A: Poles at -1, -1?

- Need 1 - k₁ = -1 → **k₁ = 2**
- Uncontrollable pole already at -1 ✓

$$\boxed{\text{YES, K = [2, 0]}}$$

---

## Part B: Poles at -2, -2?

- Can set 1 - k₁ = -2 → k₁ = 3
- BUT: other pole **stuck at -1**, not -2!

$$\boxed{\text{NO, uncontrollable pole at -1 can't move}}$$

---

## Summary

| Poles | Possible? | Reason |
|-------|-----------|--------|
| -1, -1 | ✅ YES | -1 already there |
| -2, -2 | ❌ NO | Can't move -1 pole |
