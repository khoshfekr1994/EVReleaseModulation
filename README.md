# Cardiac Electrophysiology and Extracellular Vesicle Release Model

## Overview

This project implements a comprehensive mathematical model of cardiac electrophysiology with a focus on calcium dynamics and extracellular vesicle (EV) release mechanisms. The model simulates the complex interplay between action potentials, calcium cycling, and EV release rates in cardiac cells under various physiological conditions and external control signals.

## Scientific Background

The model is based on established cardiac electrophysiology principles and incorporates:

- **Action Potential Generation**: Simulation of cardiac cell electrical activity
- **Calcium Dynamics**: Detailed modeling of intracellular calcium cycling including:
  - L-type calcium channels (LTCC)
  - Sarcoplasmic reticulum (SR) calcium release and uptake
  - Sodium-calcium exchanger (NCX)
  - Calcium buffering mechanisms
- **Extracellular Vesicle Release**: Novel modeling of EV release rates modulated by calcium dynamics and external control signals
- **Heart Rate Variability**: Analysis across physiological heart rates (60-120 bpm)

## Key Features

- Multi-compartment calcium model (cytoplasm, sub-membrane space, sarcoplasmic reticulum)
- Voltage-dependent and calcium-dependent ion channel kinetics
- Calcium-induced calcium release (CICR) mechanisms
- Extracellular vesicle release rate calculations
- Control signal modulation capabilities
- Heart rate dependency analysis

## File Structure

### Core Model Components

- **`diff_ca_eqs.m`** - Main differential equation system for calcium dynamics
- **`AP.m`** - Action potential waveform generation
- **`EVReleaseWithControlSignals.m`** - Main simulation script for EV release analysis

### Ion Channels and Transporters

- **`I_ca.m`** - L-type calcium current with control signal modulation
- **`M_I_ca.m`** - Baseline calcium current calculation
- **`I_naca.m`** - Sodium-calcium exchanger current
- **`I_up.m`** - Sarcoplasmic reticulum calcium uptake

### Calcium Handling

- **`R_ca_L.m`** - EV release rate from L-type calcium channels
- **`R_ca_m.m`** - EV release rate from sub-membrane calcium
- **`I_trpn_s.m`** - Calcium binding to troponin C
- **`Betta.m`** - Calcium buffering functions

### Utility Functions

- **`f_h.m`** - Hill function for cooperative binding
- **`QQ.m`** - Release function with threshold behavior
- **`control.m`** - Control signal generation

## Requirements

- MATLAB R2016b or later
- No additional toolboxes required (uses base MATLAB functions)

## Usage

### Basic Simulation

```matlab
% Run the main EV release simulation
EVReleaseWithControlSignals
```

This will generate:
- Control signal plots for different amplitudes and timing
- EV release rate analysis across heart rates (60-120 bpm)
- Comparative plots showing heart rate effects

### Custom Parameter Studies

```matlab
% Set global parameters for custom simulations
global T t1 t2 m;
T = 1.0;      % Pacing period (seconds)
t1 = 0.1;     % Control signal start time
t2 = 1.1;     % Control signal end time  
m = 15;       % Control signal amplitude

% Run calcium dynamics
dx = 1/1000;
c0 = [0.17; 0.09; 10; 2.5e-5; 5; 0.17]; % Initial conditions
[t,c] = ode45(@diff_ca_eqs, linspace(0,3,1/dx), c0);

% Calculate EV release rates
for i = 1:length(t)
    R_LTCC(i) = R_ca_L(c(i,6), c(i,1), t(i), T);
    R_sub(i) = R_ca_m(c(i,1));
    R_total(i) = R_LTCC(i) + R_sub(i);
end

% Plot results
figure;
semilogy(t*1000, R_total);
xlabel('Time (ms)');
ylabel('EV Release Rate');
```

## Model Variables

### State Variables (in `diff_ca_eqs.m`)
- `c(1)` - Calcium concentration in sub-membrane space (μM)
- `c(2)` - Bulk cytosolic calcium concentration (μM) 
- `c(3)` - Sarcoplasmic reticulum calcium concentration (μM)
- `c(4)` - Calcium release flux (μM/s)
- `c(5)` - Junctional SR calcium concentration (μM)
- `c(6)` - Local calcium concentration near L-type channels (μM)

### Key Parameters
- Heart rates: 60, 80, 100, 120 bpm
- Control signal amplitudes: 10, 15, 20, 25 μM/s
- Temperature: 308 K (35°C)
- External calcium: 1.8 mM

## Output Interpretation

The model generates:

1. **Control Signal Plots**: Show the temporal profile of applied control signals
2. **EV Release Rate Plots**: Logarithmic plots showing EV release rates over time
3. **Heart Rate Comparison**: Analysis of how different pacing rates affect EV release

The EV release rates typically show:
- Baseline release from sub-membrane calcium
- Spike-triggered release following action potentials
- Modulation by control signals
- Heart rate-dependent variations

## References

The model incorporates elements from established cardiac models including:
- Luo-Rudy dynamic model for ionic currents
- Standard calcium cycling mechanisms
- Novel EV release formulations

---

## Citation

If you use this code in your research, please cite:

```bibtex
@ARTICLE{9488662,
  author={Rudsari, Hamid Khoshfekr and Veletić, Mladen and Bergsland, Jacob and Balasingham, Ilangko},
  journal={IEEE Transactions on NanoBioscience}, 
  title={Targeted Drug Delivery for Cardiovascular Disease: Modeling of Modulated Extracellular Vesicle Release Rates}, 
  year={2021},
  volume={20},
  number={4},
  pages={444-454},
  keywords={Calcium;Targeted drug delivery;Molecular communication (telecommunication);Mathematical models;Cardiovascular diseases;Extracellular;Targeted drug delivery;cardiovascular diseases;molecular communication;extracellular vesicle;intracellular calcium signaling},
  doi={10.1109/TNB.2021.3097698}}



```



## Contact

Created by Hamid Khoshfekr Rudsari
khoshfekr1994@gmail.com

---

## Publication 

H. K. Rudsari, M. Veletić, J. Bergsland and I. Balasingham, "Targeted Drug Delivery for Cardiovascular Disease: Modeling of Modulated Extracellular Vesicle Release Rates," in IEEE Transactions on NanoBioscience, vol. 20, no. 4, pp. 444-454, Oct. 2021, doi: 10.1109/TNB.2021.3097698.
keywords: {Calcium;Targeted drug delivery;Molecular communication (telecommunication);Mathematical models;Cardiovascular diseases;Extracellular;Targeted drug delivery;cardiovascular diseases;molecular communication;extracellular vesicle;intracellular calcium signaling},



*This model is intended for research purposes and provides insights into cardiac calcium dynamics and extracellular vesicle release mechanisms.*
