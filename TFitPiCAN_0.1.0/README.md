# TFitPiCAN Documentation

Welcome to **TFitPiCAN** (Version 0.1.0), a Raspberry Pi CAN-Bus simulator application developed by Thomas Fischer under the MIT License.

## Overview

TFitPiCAN simulates and visualizes CAN-bus messages, allowing interactive workshops and testing of automotive-like scenarios (e.g., _front collision_, _ice on one wheel_, etc.).  
Key features include:
- **Scenario Manager** to load/run scenarios.
- **Multiple Language Support** (via a `LocalizationManager`).
- **Virtual or Hardware CAN Interface** (using Python-based CAN libraries).
- **Logging System** for message and scenario tracking.
- **PySide6 GUI** optimized for Raspberry Pi’s touchscreen.

## Project Structure

```plaintext
TFitPiCAN_0.1.0/
├── src/
│   ├── main.py
│   ├── tfitpican_simulator/
│   │   ├── can_sim.py
│   │   ├── can_manager.py
│   │   └── ...
│   ├── gui/
│   │   ├── main_window.py
│   │   ├── scenario_tab.py
│   │   ├── car_view.py
│   │   └── ...
│   ├── scenarios/
│   │   └── scenario_manager.py
│   └── ...
├── tests/
│   └── test_can_sim.py
├── docs/
│   └── index.md
├── requirements.txt
└── README.md
