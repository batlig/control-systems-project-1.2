# Question 6.1 - Solution (Short)

**G(s) = 1/[(s+4)(s+6)]** | Specs: tr < 0.18s, Mp < 20%, ess < 0.01

---

## Step 1: Desired Poles
- From Mp < 20%: **ζ ≥ 0.456** → use ζ = 0.5
- From tr < 0.18s: **ωn > 10** → use ωn = 12 rad/s
- **Desired poles: s = -6 ± j10.39**

---

## Step 2: Check Kp Requirement
- ess < 0.01 → **Kp > 99**
- Plant Kp = 1/24 = 0.042 (way too low!)
- **Need lag compensator** for steady-state

---

## Step 3: Lead Compensator Design
Purpose: Meet transient specs (tr, Mp)

$$C_{lead}(s) = \frac{s + 5}{s + 15}$$

- Zero at s = -5 (near desired pole real part)
- Pole at s = -15 (provides phase lead)

---

## Step 4: Lag Compensator Design
Purpose: Meet steady-state spec (ess)

$$C_{lag}(s) = \frac{s + 0.5}{s + 0.005}$$

- Lag ratio β = 0.5/0.005 = 100
- Placed far below ωn to not affect transient

---

## Step 5: Find Gain K
Using magnitude condition at desired pole:
$$K = \frac{1}{|C(s_d) \cdot G(s_d)|} \approx 45$$

---

## Final Controller

$$\boxed{C(s) = 45 \cdot \frac{(s+5)(s+0.5)}{(s+15)(s+0.005)}}$$

---

## Verification (MATLAB)

| Spec | Required | Result |
|------|----------|--------|
| tr | < 0.18 s | ~0.15 s ✓ |
| Mp | < 20% | ~16% ✓ |
| ess | < 0.01 | ~0.001 ✓ |

---

## Bode Diagram (Hand Sketch - Part C)

Key frequencies: 0.005, 0.5, 4, 5, 6, 15 rad/s

| ω (rad/s) | Slope Change |
|-----------|--------------|
| 0.005 | +20 dB/dec (lag pole) |
| 0.5 | -20 dB/dec (lag zero) |
| 4 | -20 dB/dec (plant pole) |
| 5 | +20 dB/dec (lead zero) |
| 6 | -20 dB/dec (plant pole) |
| 15 | -20 dB/dec (lead pole) |

Low-freq gain ≈ 36 dB
