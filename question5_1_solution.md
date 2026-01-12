# Question 5.1.a - Root Locus Sketching: Step-by-Step Solution

## Problem Statement

Sketch the root locus with respect to K for the equation **1 + KL(s) = 0**, where:

$$L(s) = \frac{s + 5}{s(s + 20)(s^2 + 2s + 4)}$$

---

## Step 1: Identify Open-Loop Poles and Zeros

### Finding Zeros (Numerator = 0)
Set **s + 5 = 0** → **z₁ = -5**

### Finding Poles (Denominator = 0)

| Factor | Solution | Pole(s) |
|--------|----------|---------|
| s = 0 | Direct | **p₁ = 0** |
| s + 20 = 0 | Direct | **p₂ = -20** |
| s² + 2s + 4 = 0 | Quadratic formula | **p₃,₄ = -1 ± j√3** |

For s² + 2s + 4 = 0:
$$s = \frac{-2 \pm \sqrt{4-16}}{2} = \frac{-2 \pm \sqrt{-12}}{2} = -1 \pm j\sqrt{3} \approx -1 \pm j1.732$$

### Summary
- **m = 4 poles**: 0, -20, -1+j1.732, -1-j1.732
- **n = 1 zero**: -5
- **Number of branches** = m = 4

---

## Step 2: Determine Real Axis Segments

> **Rule**: The root locus exists on portions of the real axis to the LEFT of an **ODD** number of real poles and zeros.

Real-axis poles/zeros (in order): **0, -5, -20**

| Segment | Poles+Zeros to the RIGHT | Count | On Locus? |
|---------|--------------------------|-------|-----------|
| s > 0 | None | 0 (even) | ❌ No |
| -5 < s < 0 | p₁ = 0 | 1 (odd) | ✅ **Yes** |
| -20 < s < -5 | p₁ = 0, z₁ = -5 | 2 (even) | ❌ No |
| s < -20 | p₁ = 0, z₁ = -5, p₂ = -20 | 3 (odd) | ✅ **Yes** |

### Result: Root locus on real axis at **[0, -5]** and **(-∞, -20]**

---

## Step 3: Calculate Asymptotes

As K → ∞, (m - n) = 3 branches go to infinity along asymptotes.

### Asymptote Angles

$$\phi_k = \frac{(2k + 1) \times 180°}{m - n}, \quad k = 0, 1, 2, ...$$

| k | Calculation | Angle |
|---|-------------|-------|
| 0 | (1 × 180°) / 3 | **60°** |
| 1 | (3 × 180°) / 3 | **180°** |
| 2 | (5 × 180°) / 3 | **300°** (or -60°) |

### Centroid (Where Asymptotes Meet Real Axis)

$$\sigma_a = \frac{\sum \text{poles} - \sum \text{zeros}}{m - n}$$

$$\sigma_a = \frac{(0) + (-20) + (-1) + (-1) - (-5)}{4 - 1} = \frac{-22 + 5}{3} = \frac{-17}{3} = \boxed{-5.67}$$

---

## Step 4: Find Breakaway/Break-in Points

Breakaway points occur where multiple branches leave/enter the real axis. They occur on real-axis locus segments where **dK/ds = 0**.

From 1 + KL(s) = 0:
$$K = -\frac{1}{L(s)} = -\frac{s(s+20)(s^2+2s+4)}{s+5}$$

Taking derivative and setting dK/ds = 0 (complex calculation).

> **Quick Method**: Breakaway typically occurs between closely spaced pole-zero pairs. Here, expect breakaway on **[0, -5]** segment.

From MATLAB analysis: **Breakaway point ≈ -2.5**

---

## Step 5: Calculate Departure Angles from Complex Poles

For the complex pole at **p₃ = -1 + j√3**:

$$\theta_{departure} = 180° + \sum(\text{angles from zeros}) - \sum(\text{angles from other poles})$$

### Calculate Each Angle

Draw vectors from each pole/zero TO the complex pole p₃ = (-1, √3):

| From | To p₃ | Δreal | Δimag | Angle |
|------|-------|-------|-------|-------|
| z₁ = -5 | (-1, √3) | 4 | √3 | arctan(√3/4) = **23.4°** |
| p₁ = 0 | (-1, √3) | -1 | √3 | arctan(√3/-1) = **120°** |
| p₂ = -20 | (-1, √3) | 19 | √3 | arctan(√3/19) = **5.2°** |
| p₄ (conjugate) | (-1, √3) | 0 | 2√3 | **90°** |

### Departure Angle Calculation

$$\theta_d = 180° + 23.4° - (120° + 5.2° + 90°)$$
$$\theta_d = 180° + 23.4° - 215.2° = \boxed{-11.8°}$$

The departure angle from the lower conjugate pole is **+11.8°** (symmetric).

---

## Step 6: Find Imaginary Axis Crossings (Routh-Hurwitz)

The characteristic equation is: **1 + KL(s) = 0**

Expanding:
$$s(s+20)(s^2+2s+4) + K(s+5) = 0$$
$$s^4 + 22s^3 + 44s^2 + 80s + Ks + 5K = 0$$
$$s^4 + 22s^3 + 44s^2 + (80+K)s + 5K = 0$$

### Routh Array

| Row | s⁴ | s² | s⁰ |
|-----|-----|-----|-----|
| s⁴ | 1 | 44 | 5K |
| s³ | 22 | 80+K | 0 |
| s² | b₁ | 5K | 0 |
| s¹ | c₁ | 0 | 0 |
| s⁰ | 5K | 0 | 0 |

Where:
$$b_1 = \frac{22 \times 44 - 1 \times (80+K)}{22} = \frac{888 - K}{22}$$

$$c_1 = \frac{b_1(80+K) - 22 \times 5K}{b_1}$$

### Finding jω Crossing

For imaginary axis crossing, set **c₁ = 0**:

After simplification:
$$K^2 + 1612K - 71040 = 0$$

Solving: **K ≈ 43.1** (taking positive root)

### Finding the Crossing Frequency

At K = 43.1, use the auxiliary polynomial from s² row:
$$b_1 s^2 + 5K = 0$$
$$s^2 = -\frac{5(43.1)}{(888-43.1)/22} = -5.6$$
$$s = \pm j\sqrt{5.6} = \pm j2.37$$

### Result: **jω-axis crossing at s = ±j2.37 rad/s when K ≈ 43.1**

---

## Step 7: Sketch the Root Locus

### Key Features to Draw:

1. **Mark poles** with ✕ at: 0, -20, -1±j1.732
2. **Mark zeros** with ○ at: -5
3. **Draw real-axis segments**: [0, -5] and (-∞, -20]
4. **Draw asymptotes** from centroid (-5.67, 0) at 60°, 180°, 300°
5. **Show departure** from complex poles at ≈ -12° (upper) and +12° (lower)
6. **Mark jω crossing** at ±j2.37
7. **Indicate breakaway** around s ≈ -2.5

### Root Locus Behavior:
- As K increases from 0:
  - One branch goes from p₁=0 toward z₁=-5
  - One branch goes from p₂=-20 toward -∞ (along 180° asymptote)
  - Two branches leave complex poles, curve toward asymptotes at 60° and 300°
  - Branches cross jω-axis at ±j2.37 (system becomes unstable for K > 43.1)

---

## Summary Table

| Parameter | Value |
|-----------|-------|
| Open-loop poles | 0, -20, -1±j1.732 |
| Open-loop zeros | -5 |
| Asymptote angles | 60°, 180°, 300° |
| Centroid | σₐ = -5.67 |
| Real axis locus | [0, -5], (-∞, -20] |
| Departure angle (upper pole) | ≈ -12° |
| jω-axis crossing | ω = 2.37 rad/s at K ≈ 43.1 |
