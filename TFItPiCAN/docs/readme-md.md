# TFitPiCAN: Modular CAN-Bus Simulator

- **Author:** Thomas Fischer
- **Version:** 0.1.0
- **Filename:** README.md
- **Filetype:** Markdown
- **Description:** Main project documentation file for TFitPiCAN CAN-Bus Simulator

## Overview

TFitPiCAN is a modular Python application designed for automotive CAN-Bus simulation and workshop-style learning. It features an intuitive GUI built with PySide6, automatic virtual environment setup, and dynamic loading of scenarios, libraries, and language files using YAML-based configuration.

## Key Features

- **Automated Environment Setup**: Creates Python virtual environment and installs dependencies
- **Modular Design**: 
  - GUI Management with PySide6 (LGPL-licensed) for cross-platform UI
  - CAN-Bus Simulation & Car Actions
  - Scenario Management with YAML-based configuration
  - External Library Support
  - Multi-language Support
- **Self-Test Module**: Verifies file integrity and version consistency
- **Automated Test Library**: Runs unit/integration tests
- **Logging Module**: Centralized logging functions

## Project Structure

```
TFitPiCAN/
├── src/
│   ├── can_bus_support/         # CAN Bus configuration and message handling
│   ├── tfitpican_simulator/     # Core simulation classes
│   ├── scenarios/               # Scenario logic and management
│   ├── scenario_ui/             # UI for scenario selection and control
│   ├── logging/                 # Logging system
│   ├── user_management/         # User classes and management
│   ├── gui/                     # Main GUI components
│   ├── localization/            # Language handling
│   ├── error_handling/          # Error event and management
│   ├── configuration_management/ # Configuration interfaces
│   ├── testing/                 # Test frameworks
│   └── documentation/           # Documentation generation
├── scenarios/                   # YAML scenario files
├── libraries/                   # External library modules
├── languages/                   # YAML language files
├── config.yaml                  # Main configuration file
├── venv_setup.py                # Virtual environment setup
├── requirements.txt             # Python dependencies
└── LICENSE                      # License information
```

## Getting Started

### Prerequisites

- Python 3.8+
- Raspberry Pi or macOS system
- For hardware CAN: Compatible CAN interface

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-username/TFitPiCAN.git
   cd TFitPiCAN
   ```

2. Run the virtual environment setup:
   ```
   python venv_setup.py
   ```

3. Activate the virtual environment:
   - On macOS/Linux:
     ```
     source venv/bin/activate
     ```
   - On Windows:
     ```
     venv\Scripts\activate
     ```

4. Launch the application:
   ```
   python src/gui.py
   ```

## Documentation

Detailed documentation for each module and class is available in the [docs/](docs/) directory.

## Testing

Run the automated tests:
```
python -m src.test_library
```

Run the self-test:
```
python -m src.self_test
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the LGPL License - see the [LICENSE](LICENSE) file for details.
