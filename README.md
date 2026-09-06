# CTMPF: An Underwater Optical Model Based on Color Transfer and Multi-Prior Fusion for Complex Degradation Restoration

> **Note**
> This repository provides the research implementation of CTMPF corresponding to the submitted manuscript. The code is being continuously organized and documented for improved usability and reproducibility.

## 🌊 Overview

This repository provides the official research implementation of CTMPF, a two-stage underwater image restoration framework for complex degradation.

CTMPF sequentially decouples spectral correction from spatial optical restoration. In the first stage, Color Style Transfer Correction (CSTC) establishes a stable spectral baseline through attenuation-guided color transfer. In the second stage, the In-scattering Attenuation Model (ISAM) performs spatially varying background-light and transmission estimation through multi-prior fusion, targeting haze and non-uniform illumination under complex underwater conditions.

The framework is designed to improve color naturalness, illumination consistency, haze removal, and local structural visibility without requiring a training process.

## 📁 Repository Structure

The repository is organized as follows:

- `main.m`: Main entry script for running CTMPF.
- `utils/`: Utility functions and supporting modules.
- `metrics/`: Scripts for objective image-quality evaluation.
- `image/`: Sample underwater images for testing.

## 🛠 Requirements

The code was developed and tested with:

- MATLAB R2024b
- Windows 11

CTMPF does not require model training.

## 🚀 Quick Start

1. Clone or download this repository.
2. Open the project directory in MATLAB.
3. Place the test image in the designated input directory.
4. Run:

```matlab
main
