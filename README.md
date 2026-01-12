# Control Systems Project 1.2 Solutions

MCH 3008 Control Systems - Project 1.2 complete solutions with MATLAB code and step-by-step explanations.

## 📁 Project Structure

```
├── Q5.1/          # Root Locus
├── Q5.2/          # Root Locus (Unstable Plant)
├── Q6.1/          # Lead-Lag Controller Design
├── Q6.2/          # Lag Compensator Design
├── Q7.1/          # State-Space Control (3rd order)
├── Q7.2/          # Mass-Spring-Damper System
├── Q8.1/          # Nyquist Diagram
├── Q8.2/          # Nyquist Diagram
├── Q9.1/          # Nyquist Stability Analysis
├── Q9.2/          # Nyquist Stability Analysis
├── Q10.1/         # Pole Placement
├── Q10.2/         # Pole Placement
└── project1.2.pdf # Original assignment
```

## ✅ Progress

| Question | Topic | Status |
|----------|-------|--------|
| 5.1 | Root Locus | **VERIFIED ✅** |
| 5.2 | Root Locus (Unstable Plant) | **VERIFIED ✅** |
| 6.1 | Lead-Lag Controller Design | **VERIFIED ✅** |
| 6.2 | Lag Compensator Design | **VERIFIED ✅** |
| 7.1 | State-Space Control | SKIPPED ⚪ |
| 7.2 | Mass-Spring-Damper System | SKIPPED ⚪ |
| 8.1 | Nyquist Diagram (Stable) | **VERIFIED ✅** |
| 8.2 | Nyquist Diagram (Unstable) | **VERIFIED ✅** |
| 9.1 | Nyquist Stability | SKIPPED ⚪ |
| 9.2 | Nyquist Stability | SKIPPED ⚪ |
| 10.1 | Pole Placement (Partial) | **VERIFIED ✅** |
| 10.2 | Pole Placement (Full) | **VERIFIED ✅** |

**Progress: 8/8 Requested Questions Complete**

## 📂 Each Folder Contains

- `question*.m` - MATLAB code with comments
- `*_solution.md` - Detailed step-by-step solution  
- `*_solution_short.md` - Concise student-style summary

## 🚀 How to Use

1. Open MATLAB
2. Navigate to any question folder (e.g., `Q5.1/`)
3. Run the `.m` file
4. Check the markdown files for explanations

## 📋 Requirements

- MATLAB R2020a or later
- Control System Toolbox
- Simulink (for some questions)

## 📝 Key Results

| Question | System | Result |
|----------|--------|--------|
| 5.2 | L(s) with pole at s=+1 | Cannot be stabilized |
| 6.1 | PI-Lead Controller | C(s) = 225(s+4)(s+6)/[s(s+18)] |
| 6.2 | Lag Compensator | C(s) = 3.76(s+0.1)/(s+0.0008) |
| 8.1 | Nyquist | Closed-loop **STABLE** |
| 8.2 | Nyquist | Closed-loop **UNSTABLE** |
| 10.1 | Pole Placement | -1,-1: **YES** / -2,-2: **NO** |
| 10.2 | Pole Placement | -5,-5: **YES** / -10,-10: **YES** |
