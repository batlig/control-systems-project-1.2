# Question 5.1.a - Root Locus Solution

$$L(s) = \frac{s + 5}{s(s + 20)(s^2 + 2s + 4)}$$

---

## Step 1: Poles & Zeros
- **Zeros**: z₁ = -5
- **Poles**: p₁ = 0, p₂ = -20, p₃,₄ = -1 ± j1.732
- m = 4 poles, n = 1 zero

---

## Step 2: Real Axis Segments
Root locus on real axis where **odd** number of poles+zeros to the right:
- ✅ **[0, -5]** → 1 to right (odd)
- ✅ **(-∞, -20]** → 3 to right (odd)

---

## Step 3: Asymptotes
- **Number**: m - n = 3

- **Angles**: φₖ = (2k+1)·180° / 3
  - φ₀ = **60°**, φ₁ = **180°**, φ₂ = **300°**

- **Centroid**: σₐ = (Σpoles - Σzeros)/(m-n)
  - σₐ = [0 + (-20) + (-1) + (-1) - (-5)] / 3 = **-5.67**

---

## Step 4: Departure Angle (from -1+j1.732)
θd = 180° + (angles from zeros) - (angles from other poles)
- From z₁=-5: 23.4°
- From p₁=0: 120°, p₂=-20: 5.2°, p₄(conjugate): 90°

θd = 180° + 23.4° - (120° + 5.2° + 90°) = **-11.8°**

---

## Step 5: jω-Axis Crossing (Routh-Hurwitz)
Characteristic equation: $$s⁴ + 22s³ + 44s² + (80+K)s + 5K = 0$$

From Routh array, setting s¹ row = 0:
- **K ≈ 43.1**
- **ω ≈ 2.37 rad/s**

---

## Summary
| Parameter | Value |
|-----------|-------|
| Poles | 0, -20, -1±j1.732 |
| Zeros | -5 |
| Asymptotes | 60°, 180°, 300° at σₐ = -5.67 |
| Real axis locus | [0, -5], (-∞, -20] |
| jω crossing | ±j2.37 at K ≈ 43.1 |
