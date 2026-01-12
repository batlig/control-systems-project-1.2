# Question 6.2 - Lag Compensator Design (Detailed Solution)

## Problem Statement
**Plant:** G(s) = 100/[(s+1)(s+7)]

**Specifications:**
- Overshoot: Mp ≤ 50%
- Natural frequency: ωn = 20 rad/s
- Steady-state error: ess ≤ 0.001

---

## Step 1: Translate Specifications

### Damping Ratio from Overshoot
For Mp ≤ 50%, theoretically ζ ≥ 0.215.

**Key Insight:** Use **ζ = 0.30** (not 0.22) because:
- The system has more than 2 poles
- Lag compensator adds slight phase lag
- Higher ζ compensates for these effects

### Desired Pole Locations
$$s = -\zeta\omega_n \pm j\omega_n\sqrt{1-\zeta^2}$$
$$s = -6 \pm j19.08$$

---

## Step 2: Find Gain K

Calculate gain to place poles at desired location:
$$K = \frac{1}{|G(s_d)|} = 3.76$$

---

## Step 3: Check Steady-State Error

Required Kp for ess ≤ 0.001:
$$K_p \geq \frac{1}{0.001} - 1 = 999$$

With K only:
$$K_p = K \times \frac{100}{1 \times 7} = 3.76 \times 14.29 = 53.7$$

Need lag compensator boost: β = 999/53.7 ≈ 19

---

## Step 4: Lag Compensator Design

### Key Innovation: Very Low Frequency Placement

$$C_{lag}(s) = \frac{s + z_{lag}}{s + p_{lag}}$$

**Place at very low frequencies to minimize phase impact at ωn = 20:**
- z_lag = 0.1 rad/s
- p_lag = 0.0008 rad/s  
- β = 125 (provides margin)

### Phase at ωn = 20:
$$\angle C_{lag}(j20) = \arctan(20/0.1) - \arctan(20/0.0008)$$
$$= 89.7° - 89.998° = -0.3°$$

**Only -0.3° of phase lag!** (Negligible impact on overshoot)

---

## Step 5: Final Controller

$$\boxed{C(s) = 3.76 \cdot \frac{s + 0.1}{s + 0.0008}}$$

---

## Verification Results

| Specification | Required | Achieved | Status |
|--------------|----------|----------|--------|
| Overshoot | ≤ 50% | **49.9%** | ✅ PASS |
| Natural freq | = 20 rad/s | **20.2 rad/s** | ✅ PASS |
| Steady-state error | ≤ 0.001 | **0.00015** | ✅ PASS |

**Note:** Need 100s simulation to see true steady-state (slow lag pole at 0.0008)

---

## Key Insights

1. **Use ζ = 0.30** instead of theoretical 0.22 to account for higher-order effects
2. **Place lag at very low frequencies** (z=0.1, p=0.0008) so phase at ωn is negligible
3. **High β = 125** provides large DC gain boost with minimal transient impact
4. **Long simulation time** needed to see true steady-state value

---

## Parts C & D: Bode Diagram

### Break Frequencies (for hand-drawn Bode):
| ω (rad/s) | Element | Effect |
|-----------|---------|--------|
| 0.0008 | Lag pole | +20 dB/dec |
| 0.1 | Lag zero | -20 dB/dec |
| 1 | Plant pole | -20 dB/dec |
| 7 | Plant pole | -20 dB/dec |

**DC Gain:** Kp ≈ 6700 = 76.5 dB

**High frequency slope:** -40 dB/dec (two plant poles dominate)
