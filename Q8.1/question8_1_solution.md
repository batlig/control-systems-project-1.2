# Question 8.1 - Nyquist Diagram (Detailed Solution)

## Problem Statement
Consider the feedback loop with:
$$G(s) = \frac{s^2 + 1}{s(s^2 + 2s + 3)}$$

**Tasks:**
- Plot the Nyquist diagram
- Determine if the closed-loop system is stable

---

## Step 1: Analyze Open-Loop Transfer Function

### Poles
Denominator: s(s² + 2s + 3) = 0

| Factor | Solution |
|--------|----------|
| s = 0 | **p₁ = 0** (pole at origin) |
| s² + 2s + 3 = 0 | **p₂,₃ = -1 ± j√2** |

All poles are in LHP or on jω-axis → **P = 0** (no RHP poles)

### Zeros
Numerator: s² + 1 = 0
- **z₁,₂ = ±j** (zeros on imaginary axis)

---

## Step 2: Nyquist Stability Criterion

The Nyquist criterion:
$$Z = N + P$$

Where:
- **Z** = closed-loop RHP poles (want Z = 0 for stability)
- **N** = clockwise encirclements of -1
- **P** = open-loop RHP poles = **0**

**For stability:** Z = 0 → Need N = 0 (no encirclements of -1)

---

## Step 3: Handle Pole at Origin

Since G(s) has a pole at s = 0, the standard Nyquist contour must be modified.

### Indentation Around s = 0
We use a small semicircle: s = εe^(jθ), θ: -90° → +90°

As ε → 0:
$$G(εe^{jθ}) ≈ \frac{1}{εe^{jθ} \cdot 3} = \frac{1}{3ε}e^{-jθ}$$

This traces a **large semicircle at infinity** from θ = +90° to θ = -90°.

---

## Step 4: Calculate Key Points

### Frequency Response G(jω)

$$G(jω) = \frac{(jω)^2 + 1}{jω((jω)^2 + 2jω + 3)} = \frac{1 - ω^2}{jω(3 - ω^2 + 2jω)}$$

Simplifying:
$$G(jω) = \frac{1 - ω^2}{-2ω^2 + jω(3 - ω^2)}$$

### Real-Axis Crossings
G(jω) is real when Im(G(jω)) = 0.

Setting imaginary part to zero:
$$(1 - ω^2) \cdot ω(3 - ω^2) = 0$$

Solutions: **ω = 1** and **ω = √3**

### Values at Crossings

**At ω = 1:**
$$G(j) = \frac{1-1}{...} = 0$$

**At ω = √3:**
$$G(j\sqrt{3}) = \frac{1-3}{-2(3) + 0} = \frac{-2}{-6} = \frac{1}{3} ≈ 0.333$$

Wait, let me recalculate...

Actually at ω = √3:
- Numerator: 1 - 3 = -2
- Denominator: -2(3) + j√3(3-3) = -6 + 0 = -6
- G(j√3) = -2/-6 = **1/3 ≈ 0.333**

This is **positive**, not negative! So it's to the RIGHT of -1.

### Limiting Behavior
- **ω → 0⁺:** |G| → ∞, ∠G → -90°
- **ω → ∞:** |G| → 0, ∠G → -90°

---

## Step 5: Sketch Nyquist Plot

### Nyquist Contour Mapping:

1. **ω = 0⁺:** Start at infinity, angle -90° (pointing down)
2. **ω = 1:** Crosses through origin (G = 0)
3. **ω = √3:** Crosses positive real axis at +1/3
4. **ω → ∞:** Approaches origin from angle -90°
5. **Semicircle at origin:** Large arc at infinity (from -90° to +90°)
6. **ω < 0:** Mirror image of ω > 0

### Key Observation
The Nyquist plot **does NOT encircle the point -1**.

---

## Step 6: Apply Nyquist Criterion

- **P = 0** (no open-loop RHP poles)
- **N = 0** (no encirclements of -1)

$$Z = N + P = 0 + 0 = 0$$

---

## Conclusion

$$\boxed{\text{The closed-loop system is STABLE}}$$

Since Z = 0, the closed-loop system has no poles in the RHP.

---

## Summary Table

| Parameter | Value |
|-----------|-------|
| Open-loop poles | 0, -1±j√2 |
| Open-loop zeros | ±j |
| RHP poles (P) | 0 |
| Encirclements of -1 (N) | 0 |
| Closed-loop RHP poles (Z) | 0 |
| **Stability** | **STABLE** ✓ |
