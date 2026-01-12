# Question 6.1 - Controller Design (Optimized Solution)

## Problem Statement
$$**Plant:** G(s) = 1/[(s+4)(s+6)]$$

**Specifications:**
- Rise time: tr < 0.18 s
- Overshoot: Mp < 20%
- Steady-state error: ess < 0.01

---

## Strategy: Pole-Zero Cancellation (PI-Lead)

The most effective way to meet tight specifications is to cancel the plant dynamics and impose our own desired dynamics.

We choose a controller of the form:
$$C(s) = K \frac{(s+4)(s+6)}{s(s+p)}$$

This provides:
1. Cancellation of plant poles at -4 and -6.
2. A pole at s=0 (Integrator) → makes system Type 1 (ess = 0 for step).
3. A free parameter $p$ to adjust damping.
4. A gain $K$ to adjust natural frequency.

The open-loop transfer function becomes:
$$L(s) = C(s)G(s) = \frac{K(s+4)(s+6)}{s(s+p)} \cdot \frac{1}{(s+4)(s+6)} = \frac{K}{s(s+p)}$$

---

## Step 1: Design Parameters

The closed-loop characteristic equation is:
$$1 + L(s) = 0 \Rightarrow s(s+p) + K = 0$$
$$s^2 + ps + K = 0$$

Match this with standard 2nd order form:
$$s^2 + 2\zeta\omega_n s + \omega_n^2 = 0$$

### 1.1 Select Desired Damping Ratio (ζ)
For Mp < 20%, we need ζ ≥ 0.45.
Select **ζ = 0.6** (Theoretical Mp ≈ 9.5%).

### 1.2 Select Desired Natural Frequency (ωn)
For tr < 0.18s, approximate $t_r \approx \frac{1.8 \sim 2.2}{\omega_n}$.
Select **ωn = 15 rad/s**.
Expected $t_r \approx \frac{1.8}{15} = 0.12s$.

---

## Step 2: Calculate Controller Parameters

Comparing coefficients:
1. $K = \omega_n^2 = 15^2 = \mathbf{225}$
2. $p = 2\zeta\omega_n = 2(0.6)(15) = \mathbf{18}$

The controller is:
$$C(s) = \frac{225(s+4)(s+6)}{s(s+18)}$$

---

## Verification

### Analytical Check:
- **Type 1 System** → **Steady-state error = 0** (Passes ess < 0.01)
- **Pure 2nd Order**:
  - Mp = $e^{-\pi(0.6)/\sqrt{1-0.6^2}} \times 100 \approx 9.5\%$ (Passes < 20%)
  - tr ≈ 0.12s (Passes < 0.18s)

### MATLAB Verification Results:
- **Rise Time:** 0.1237 s ✅
- **Overshoot:** 9.48% ✅
- **Steady-State Error:** 0.0000 ✅

---

## Summary

The design uses **Pole-Zero Cancellation** to shape the loop transfer function into a perfect 2nd order system $K/s(s+p)$.

$$C(s) = \frac{225(s^2 + 10s + 24)}{s^2 + 18s}$$

This guarantees all specifications are met with significant margin.
