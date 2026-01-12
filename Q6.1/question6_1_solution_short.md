# Question 6.1 Solution (Short)

## 1. Design Strategy: Pole-Zero Cancellation

The plant is:
$$G(s) = \frac{1}{(s+4)(s+6)}$$

To strictly meet the specifications ($t_r < 0.18s$, $e_{ss} < 0.01$), we use a **Pole-Zero Cancellation** controller (PI-Lead type). This allows us to shape the loop transfer function exactly into a 2nd order system with desired properties.

$$C(s) = K \frac{(s+4)(s+6)}{s(s+p)}$$

This simplifies the open loop to:
$$L(s) = \frac{K}{s(s+p)}$$

## 2. Parameter Calculation

The closed loop characteristic equation is $s^2 + ps + K = 0$.
We match this to $s^2 + 2\zeta\omega_n s + \omega_n^2 = 0$.

**1. Determine $\omega_n$ (from rise time):**
$t_r \approx 1.8/\omega_n < 0.18 \Rightarrow \omega_n > 10$.
We select **$\omega_n = 15$ rad/s** for margin.
$$K = \omega_n^2 = 15^2 = \mathbf{225}$$

**2. Determine $\zeta$ (from overshoot):**
$M_p < 20\% \Rightarrow \zeta > 0.45$.
We select **$\zeta = 0.6$** (which gives $M_p \approx 9.5\%$).
$$p = 2\zeta\omega_n = 2(0.6)(15) = \mathbf{18}$$

## 3. Final Controller

$$C(s) = \frac{225(s+4)(s+6)}{s(s+18)} = \frac{225s^2 + 2250s + 5400}{s^2 + 18s}$$

## 4. Verification

- **Rise Time:** $t_r \approx 0.12s$ (< 0.18s) ✅
- **Overshoot:** $M_p \approx 9.5\%$ (< 20%) ✅
- **Steady-State Error:** $e_{ss} = 0$ (due to integrator) (< 0.01) ✅
