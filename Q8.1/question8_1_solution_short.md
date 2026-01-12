# Question 8.1 - Solution (Short)

**G(s) = (s²+1) / [s(s²+2s+3)]**

---

## Step 1: Poles & Zeros
- **Poles**: p₁ = 0, p₂,₃ = -1 ± j√2
- **Zeros**: z₁,₂ = ±j
- **P = 0** (no RHP poles)

---

## Step 2: Nyquist Criterion
$$Z = N + P$$
- Z = closed-loop RHP poles
- N = CW encirclements of -1
- P = 0

For stability: need **N = 0**

---

## Step 3: Handle Pole at Origin
- Indent around s = 0 with small semicircle
- Creates large arc at infinity (from -90° to +90°)

---

## Step 4: Key Points

| ω | G(jω) | Notes |
|---|-------|-------|
| 0⁺ | ∞∠-90° | Starts at infinity |
| 1 | 0 | Crosses origin |
| √3 | +1/3 | Positive real axis |
| ∞ | 0∠-90° | Approaches origin |

---

## Step 5: Encirclements
The Nyquist plot does **NOT** encircle -1.

**N = 0**

---

## Step 6: Stability

$$Z = N + P = 0 + 0 = 0$$

$$\boxed{\text{Closed-loop is STABLE}}$$

---

## Summary
| P | N | Z | Stable? |
|---|---|---|---------|
| 0 | 0 | 0 | ✅ YES |
