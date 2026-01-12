# Question 8.2 - Nyquist Diagram (Detailed Solution)

## Problem Statement
Consider the feedback loop with:
$$G(s) = \frac{1}{s^4 + 5}$$

With forward path gain of 10, so:
$$L(s) = \frac{10}{s^4 + 5}$$

**Tasks:**
- Plot the Nyquist diagram
- Determine if the closed-loop system is stable

---

## Step 1: Analyze Open-Loop Poles

### Finding Poles
$$s^4 + 5 = 0 \Rightarrow s^4 = -5$$

Express -5 in polar form:
$$-5 = 5e^{j\pi}$$

The four roots are:
$$s = 5^{1/4} \cdot e^{j(\pi + 2k\pi)/4}, \quad k = 0, 1, 2, 3$$

| k | Angle | Pole Location |
|---|-------|---------------|
| 0 | 45° | **p₁ = 1.057 + j1.057** (RHP) |
| 1 | 135° | **p₂ = -1.057 + j1.057** (LHP) |
| 2 | 225° | **p₃ = -1.057 - j1.057** (LHP) |
| 3 | 315° | **p₄ = 1.057 - j1.057** (RHP) |

### Count RHP Poles
**P = 2** (two poles in right half-plane)

---

## Step 2: Nyquist Criterion Setup

$$Z = N + P$$

Where:
- Z = closed-loop RHP poles
- N = clockwise encirclements of -1
- **P = 2**

For stability (Z = 0), we need:
$$N = -P = -2$$

This means we need **2 counter-clockwise encirclements** of -1.

---

## Step 3: Analyze Frequency Response

### Key Observation!
$$(j\omega)^4 = \omega^4$$

This is because:
$$(j\omega)^4 = j^4 \cdot \omega^4 = 1 \cdot \omega^4 = \omega^4$$

Therefore:
$$L(j\omega) = \frac{10}{(j\omega)^4 + 5} = \frac{10}{\omega^4 + 5}$$

**L(jω) is ALWAYS REAL and POSITIVE for all ω!**

### Key Values

| ω (rad/s) | L(jω) |
|-----------|-------|
| 0 | 10/5 = **2** |
| 1 | 10/6 = 1.67 |
| 2 | 10/21 = 0.48 |
| ∞ | **0** |

---

## Step 4: Nyquist Plot Shape

Since L(jω) is always real and positive:
- The Nyquist plot is a **line segment on the positive real axis**
- Starts at **L(0) = 2** when ω = 0
- Decreases to **0** as ω → ∞
- The plot for ω < 0 traces the same path (symmetric)

### Complete Nyquist Contour:
```
      Im
       |
       |
-------+---[0]=====[2]----> Re
       |
       |
       
The plot is just [0, 2] on the positive real axis!
```

---

## Step 5: Count Encirclements

The Nyquist plot:
- Lies entirely on the **positive real axis**
- Never approaches or encircles the point **-1**

**N = 0** (no encirclements)

---

## Step 6: Apply Nyquist Criterion

$$Z = N + P = 0 + 2 = 2$$

**The closed-loop system has 2 RHP poles!**

---

## Step 7: Verification

Closed-loop transfer function:
$$T(s) = \frac{L(s)}{1 + L(s)} = \frac{10}{s^4 + 15}$$

Closed-loop poles: roots of s⁴ + 15 = 0
- Same structure as open-loop, just with 15 instead of 5
- Still has 2 poles in RHP!

---

## Conclusion

$$\boxed{\text{The closed-loop system is UNSTABLE}}$$

- **P = 2** (open-loop RHP poles)
- **N = 0** (no encirclements of -1)
- **Z = 2** (closed-loop RHP poles)

The Nyquist plot doesn't encircle -1 at all, but since the open-loop already has 2 RHP poles, we needed 2 CCW encirclements to stabilize. We got none → **UNSTABLE**.

---

## Summary Table

| Parameter | Value |
|-----------|-------|
| Open-loop poles | ±1.057 ± j1.057 |
| RHP poles (P) | 2 |
| Nyquist plot | Positive real axis [0, 2] |
| Encirclements (N) | 0 |
| Z = N + P | 2 |
| **Stability** | **UNSTABLE** ❌ |
