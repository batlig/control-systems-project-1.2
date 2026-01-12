# Question 5.2 - Root Locus Analysis (Detailed Solution)

## Problem Statement
Sketch the root locus for: **1 + KL(s) = 0**

$$L(s) = \frac{s}{(s-1)(s+4)(s^2 + 6s + 9)}$$

**Note:** s² + 6s + 9 = (s+3)² — repeated real poles!

---

## Step 1: Identify Open-Loop Poles and Zeros

### Zeros (Numerator = 0)
$$s = 0$$
**z₁ = 0** (at origin)

### Poles (Denominator = 0)
| Factor | Pole(s) |
|--------|---------|
| s - 1 = 0 | **p₁ = +1** ⚠️ UNSTABLE! |
| s + 4 = 0 | **p₂ = -4** |
| (s + 3)² = 0 | **p₃ = p₄ = -3** (repeated) |

### Summary
- **m = 4 poles**: +1, -4, -3, -3
- **n = 1 zero**: 0
- **Number of branches** = 4

---

## Step 2: Real Axis Segments

> **Rule:** Root locus exists on real axis to the LEFT of an ODD number of poles + zeros.

Poles/zeros on real axis (left to right): -4, -3 (×2), 0, +1

| Segment | Count to Right | On Locus? |
|---------|---------------|-----------|
| s > +1 | 0 (even) | ❌ No |
| 0 < s < +1 | 1 pole (odd) | ✅ **Yes** |
| -3 < s < 0 | 2 (even) | ❌ No |
| -4 < s < -3 | 4 (even) | ❌ No |
| s < -4 | 5 (odd) | ✅ **Yes** |

**Real axis locus: [0, +1] and (-∞, -4]**

---

## Step 3: Asymptotes

### Number of Asymptotes
$$m - n = 4 - 1 = 3$$

### Asymptote Angles
$$\phi_k = \frac{(2k+1) \times 180°}{m-n}$$

| k | Angle |
|---|-------|
| 0 | **60°** |
| 1 | **180°** |
| 2 | **300°** |

### Centroid
$$\sigma_a = \frac{\sum \text{poles} - \sum \text{zeros}}{m - n}$$
$$\sigma_a = \frac{(+1) + (-4) + (-3) + (-3) - (0)}{3} = \frac{-9}{3} = -3$$

**Centroid: σₐ = -3**

---

## Step 4: Breakaway/Break-in Points

- **Segment [0, +1]:** Break-in point (branches enter real axis)
- **Segment (-∞, -4]:** Breakaway point (branches leave to asymptotes)

---

## Step 5: Behavior at Repeated Pole

At **s = -3** (multiplicity 2):
- Two branches meet at this point
- They depart at **±90°** to each other
- This creates the characteristic "butterfly" pattern

---

## Step 6: Imaginary Axis Crossings (Routh-Hurwitz)

### Characteristic Equation
$$1 + K \cdot L(s) = 0$$
$$(s-1)(s+4)(s+3)^2 + Ks = 0$$

Expanding:
$$s^4 + 9s^3 + 23s^2 + (3+K)s - 36 = 0$$

### Routh Array
| | s⁴ | s² | s⁰ |
|--|----|----|-----|
| s⁴ | 1 | 23 | -36 |
| s³ | 9 | 3+K | 0 |
| s² | b₁ | -36 | 0 |
| s¹ | c₁ | 0 | 0 |
| s⁰ | -36 | 0 | 0 |

Where:
- b₁ = (9×23 - (3+K))/9 = (204-K)/9
- c₁ = (b₁(3+K) + 324)/b₁

### Critical Observation ⚠️
**The s⁰ row is -36, which is always NEGATIVE!**

This means the system has a sign change in the first column for ALL values of K > 0.
→ **System cannot be stabilized with proportional gain alone!**

### Finding jω Crossing
Set c₁ = 0 and solve:
$$K^2 - 201K - 3528 = 0$$
$$K = \frac{201 + \sqrt{201^2 + 4(3528)}}{2} \approx 217.6$$

At K ≈ 217.6:
$$\omega \approx 2.1 \text{ rad/s}$$

**jω-axis crossing: s = ±j2.1 at K ≈ 217.6**

---

## Step 7: Root Locus Sketch

### Key Features:
1. ✕ Mark poles at: +1, -4, -3 (double)
2. ○ Mark zero at: 0
3. Real axis segments: [0, +1] and (-∞, -4]
4. Asymptotes from σₐ = -3 at 60°, 180°, 300°
5. Branches from -3 depart at ±90°
6. jω crossing at ±j2.1

### Root Locus Behavior:
- K = 0: Poles at +1, -4, -3, -3
- As K ↑: One branch goes from +1 toward zero at 0
- Another branch from -4 goes to -∞
- Two branches from -3 curve toward 60° and 300° asymptotes
- Crosses jω axis at ω ≈ 2.1 for K ≈ 217.6

---

## Summary Table

| Parameter | Value |
|-----------|-------|
| Poles | +1, -4, -3 (×2) |
| Zeros | 0 |
| Asymptotes | 60°, 180°, 300° |
| Centroid | σₐ = -3 |
| Real axis locus | [0, +1], (-∞, -4] |
| jω crossing | ω ≈ 2.1 at K ≈ 217.6 |
| **Stability** | **CANNOT be stabilized!** |
