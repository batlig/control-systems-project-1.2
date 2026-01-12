# Question 6.2 - Lag Compensator Design (Detailed Solution)

## Problem Statement
**Plant:** G(s) = 100/[(s+1)(s+7)]

**Design a lag compensator C(s) using root locus to achieve:**
- Overshoot: Mp ≤ 50%
- Natural frequency: ωn = 20 rad/s
- Steady-state error: ess ≤ 0.001

---

## Step 1: Translate Specifications to s-Domain

### 1.1 Find Required Damping Ratio (ζ) from Overshoot

The overshoot formula:
$$M_p = e^{-\pi\zeta/\sqrt{1-\zeta^2}}$$

For Mp = 50%:
$$0.50 = e^{-\pi\zeta/\sqrt{1-\zeta^2}}$$

Solving: **ζ ≥ 0.215**

Select **ζ = 0.22** for slight margin.

### 1.2 Calculate Desired Pole Locations

Given ωn = 20 rad/s and ζ = 0.22:
$$s = -\zeta\omega_n \pm j\omega_n\sqrt{1-\zeta^2}$$
$$s = -0.22(20) \pm j(20)\sqrt{1-0.0484}$$
$$s = -4.4 \pm j19.51$$

**Desired dominant poles: s = -4.4 ± j19.51**

---

## Step 2: Analyze Steady-State Error Requirement

### 2.1 Required Position Error Constant

For unit step input:
$$e_{ss} = \frac{1}{1+K_p}$$

Required ess ≤ 0.001:
$$K_p \geq \frac{1}{0.001} - 1 = 999$$

### 2.2 Plant's Kp

$$K_{p,plant} = \lim_{s\to 0} G(s) = \frac{100}{(1)(7)} = 14.29$$

**Kp ratio needed: 999/14.29 ≈ 70**

This is a large ratio - perfect case for a **lag compensator**.

---

## Step 3: Lag Compensator Theory

### 3.1 Lag Compensator Form
$$C_{lag}(s) = K \cdot \frac{s + z_{lag}}{s + p_{lag}}, \quad z_{lag} > p_{lag}$$

**Key properties:**
- At DC (s=0): Gain = K × (z_lag/p_lag) = K × β
- The ratio β = z_lag/p_lag boosts low-frequency gain
- At high frequencies: Gain ≈ K (zero and pole cancel out)
- Phase is slightly negative (lag), but minimal at high frequencies

### 3.2 Why Lag Works
- Boosts Kp without significantly affecting transient response
- Place z_lag and p_lag far below the desired pole frequency
- The phase lag occurs at low frequencies where it doesn't hurt

---

## Step 4: Design Procedure

### 4.1 Find Gain K for Desired Poles

First, assume no lag compensator (or β ≈ 1 near ωn).

At s_d = -4.4 + j19.51:
$$K = \frac{1}{|G(s_d)|}$$

Calculate |G(s_d)|:
- |s_d + 1| = |-3.4 + j19.51| = 19.80
- |s_d + 7| = |2.6 + j19.51| = 19.68
- |100| = 100

$$|G(s_d)| = \frac{100}{19.80 \times 19.68} = 0.2566$$

$$K = \frac{1}{0.2566} = 3.90$$

### 4.2 Check Kp with Gain K Only

$$K_p = K \times \frac{100}{1 \times 7} = 3.90 \times 14.29 = 55.7$$

Still need Kp ≥ 999, so:
$$\beta_{required} = \frac{999}{55.7} = 17.9$$

### 4.3 Select Lag Compensator Parameters

**Select β = 22** (with margin)

**Place lag zero:** z_lag = 2 (well below ωn = 20)

**Calculate lag pole:** p_lag = z_lag/β = 2/22 = 0.091

### 4.4 Final Lag Compensator

$$C_{lag}(s) = \frac{s + 2}{s + 0.091}$$

---

## Step 5: Adjust Gain K

The lag compensator slightly affects the magnitude at s_d.

Calculate |C_lag(s_d)|:
- |s_d + 2| = |-2.4 + j19.51| = 19.66
- |s_d + 0.091| = |-4.31 + j19.51| = 19.98

$$|C_{lag}(s_d)| = \frac{19.66}{19.98} = 0.984$$

Adjusted gain:
$$K_{adjusted} = \frac{K}{|C_{lag}(s_d)|} = \frac{3.90}{0.984} = 3.96$$

---

## Step 6: Final Controller

$$\boxed{C(s) = 3.96 \cdot \frac{s + 2}{s + 0.091}}$$

Or equivalently:
$$C(s) = \frac{3.96(s + 2)}{s + 0.091}$$

---

## Verification

### Check Kp:
$$K_p = 3.96 \times \frac{2}{0.091} \times \frac{100}{7} = 3.96 \times 21.98 \times 14.29 = 1244$$

$$e_{ss} = \frac{1}{1+1244} = 0.0008 < 0.001$$ ✓

### Check Mp and ωn:
Run MATLAB simulation - the poles should be near s = -4.4 ± j19.51

---

## Parts C & D: Bode Diagram

### Hand-Drawn Bode (Part C)

**Break frequencies:** 0.091, 1, 2, 7 rad/s

| ω (rad/s) | Event | Slope Change |
|-----------|-------|--------------|
| 0.091 | Lag pole | +20 dB/dec |
| 1 | Plant pole | -20 dB/dec |
| 2 | Lag zero | -20 dB/dec |
| 7 | Plant pole | -20 dB/dec |

**DC gain:** 
$$|C(0)G(0)| = 3.96 \times \frac{2}{0.091} \times \frac{100}{7} = 1244$$
$$= 20\log_{10}(1244) = 61.9 \text{ dB}$$

**High frequency slope:** -40 dB/dec (two plant poles dominate)

### MATLAB Bode (Part D)
Run `question6_2.m` for accurate Bode plot.

---

## Summary

| Parameter | Value |
|-----------|-------|
| Controller Type | Lag Compensator |
| Gain K | 3.96 |
| Lag Zero | z_lag = 2 |
| Lag Pole | p_lag = 0.091 |
| Beta (DC gain boost) | 22 |
| Final Kp | ~1244 |
| ess | ~0.0008 |
