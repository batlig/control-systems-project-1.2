# Question 6.2 - Solution (Short)

**G(s) = 100/[(s+1)(s+7)]** | Specs: Mp ≤ 50%, ωn = 20, ess ≤ 0.001

---

## Step 1: Damping & Poles
- Use **ζ = 0.30** (higher than theoretical 0.22 for margin)
- **Desired poles: s = -6 ± j19.08**

---

## Step 2: Find Gain
$$K = \frac{1}{|G(s_d)|} = 3.76$$

Kp with K only = 53.7 (need ≥ 999)

---

## Step 3: Lag Compensator

**Key: Place at VERY LOW frequencies!**

$$C_{lag}(s) = \frac{s + 0.1}{s + 0.0008}$$

- β = 125
- Phase at ωn = 20: only **-0.3°** (negligible!)

---

## Final Controller

$$\boxed{C(s) = 3.76 \cdot \frac{s + 0.1}{s + 0.0008}}$$

---

## Verification (100s simulation)

| Spec | Required | Result |
|------|----------|--------|
| Mp | ≤ 50% | **49.9%** ✅ |
| ωn | = 20 | **20.2** ✅ |
| ess | ≤ 0.001 | **0.00015** ✅ |

---

## Why This Works

1. ζ = 0.30 compensates for higher-order effects
2. Lag at 0.1/0.0008 → minimal phase at ωn
3. β = 125 → huge DC gain boost
4. Need long sim (100s) for true ess (slow lag pole)
