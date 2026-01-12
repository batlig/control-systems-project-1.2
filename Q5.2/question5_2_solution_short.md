# Question 5.2 - Solution (Short)

**L(s) = s / [(s-1)(s+4)(s+3)²]**

⚠️ **Unstable pole at s = +1!**

---

## Step 1: Poles & Zeros
- **Zeros**: z₁ = 0
- **Poles**: p₁ = +1 ⚠️, p₂ = -4, p₃,₄ = -3 (repeated)
- m = 4, n = 1

---

## Step 2: Real Axis Segments
| Segment | To Right | On Locus? |
|---------|----------|-----------|
| (0, +1) | 1 odd | ✅ Yes |
| (-∞, -4) | 5 odd | ✅ Yes |

**Locus on: [0, +1] and (-∞, -4]**

---

## Step 3: Asymptotes
- **Number**: m - n = 3
- **Angles**: 60°, 180°, 300°
- **Centroid**: σₐ = (+1-4-3-3-0)/3 = **-3**

---

## Step 4: Repeated Pole at s = -3
Two branches depart at **±90°**

---

## Step 5: jω-Axis Crossing
Char. eqn: s⁴ + 9s³ + 23s² + (3+K)s - 36 = 0

From Routh array:
- **K ≈ 217.6**
- **ω ≈ 2.1 rad/s**

---

## ⚠️ Stability Analysis

The s⁰ row of Routh array = **-36** (always negative!)

**→ System CANNOT be stabilized with any K > 0**

---

## Summary

| Parameter | Value |
|-----------|-------|
| Poles | +1, -4, -3, -3 |
| Zeros | 0 |
| Asymptotes | 60°, 180°, 300° at σₐ = -3 |
| Real axis | [0,+1], (-∞,-4] |
| jω crossing | ±j2.1 at K ≈ 217.6 |
| **Stable?** | **NO** ❌ |
