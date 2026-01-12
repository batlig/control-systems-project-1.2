# Question 8.2 - Solution (Short)

**L(s) = 10 / (s⁴ + 5)** (with gain 10 from diagram)

---

## Step 1: Open-Loop Poles
s⁴ + 5 = 0 → s⁴ = -5

Poles at angles 45°, 135°, 225°, 315° with magnitude 5^(1/4) ≈ 1.495

- **p₁,₄ = ±1.057 ± j1.057** → 2 in RHP!
- **P = 2**

---

## Step 2: Key Insight!

$$(jω)^4 = ω^4$$ (real!)

So:
$$L(jω) = \frac{10}{ω^4 + 5}$$

**L(jω) is always REAL and POSITIVE!**

---

## Step 3: Nyquist Plot

| ω | L(jω) |
|---|-------|
| 0 | 2 |
| ∞ | 0 |

The Nyquist plot is just a line from **0 to 2 on positive real axis**.

---

## Step 4: Encirclements

Plot lies on positive real axis → **doesn't touch -1**

**N = 0**

---

## Step 5: Stability

$$Z = N + P = 0 + 2 = 2$$

$$\boxed{\text{Closed-loop is UNSTABLE}}$$

---

## Summary

| P | N | Z | Stable? |
|---|---|---|---------|
| 2 | 0 | 2 | ❌ NO |

Need 2 CCW encirclements to stabilize, got 0 → **UNSTABLE**
