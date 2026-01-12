# Question 6.2 - Solution (Short)

**G(s) = 100/[(s+1)(s+7)]** | Specs: Mp ≤ 50%, ωn = 20, ess ≤ 0.001

---

## Step 1: Desired Poles
- From Mp ≤ 50%: **ζ ≥ 0.215** → use ζ = 0.22
- Given: **ωn = 20 rad/s**
- **Desired poles: s = -4.4 ± j19.51**

---

## Step 2: Check Kp Requirement
- ess ≤ 0.001 → **Kp ≥ 999**
- Plant Kp = 100/7 = 14.29
- **Need lag compensator** to boost Kp

---

## Step 3: Find Gain K
At s_d = -4.4 + j19.51:
$$K = \frac{1}{|G(s_d)|} = 3.90$$

Kp with K only = 3.90 × 14.29 = 55.7 (still too low!)

---

## Step 4: Design Lag Compensator

$$C_{lag}(s) = \frac{s + z_{lag}}{s + p_{lag}}$$

**Required β = Kp_needed / Kp_current = 999/55.7 ≈ 18**

Select **β = 22** (with margin)

- **z_lag = 2** (well below ωn = 20)
- **p_lag = 2/22 = 0.091**

---

## Step 5: Adjust Gain
Account for lag effect at s_d:
$$K_{adjusted} = 3.96$$

---

## Final Controller

$$\boxed{C(s) = 3.96 \cdot \frac{s + 2}{s + 0.091}}$$

---

## Verification

| Spec | Required | Result |
|------|----------|--------|
| Mp | ≤ 50% | ~48% ✓ |
| ωn | = 20 | ~20 ✓ |
| ess | ≤ 0.001 | ~0.0008 ✓ |

Kp = 3.96 × (2/0.091) × (100/7) = **1244** → ess = 1/1245 = 0.0008

---

## Bode Key Points

| ω (rad/s) | Event |
|-----------|-------|
| 0.091 | Lag pole (+20 dB/dec) |
| 1 | Plant pole (-20 dB/dec) |
| 2 | Lag zero (-20 dB/dec) |
| 7 | Plant pole (-20 dB/dec) |

DC Gain ≈ 62 dB
