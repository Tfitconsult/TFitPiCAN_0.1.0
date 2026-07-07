# TFitPiCAN Architecture Overview

- **Author:** Thomas Fischer
- **Version:** 0.1.0
- **Filename:** ARCHITECTURE.md
- **Filetype:** Markdown
- **Description:** High-level architecture documentation for TFitPiCAN CAN-Bus Simulator

## System Architecture

TFitPiCAN is built on a modular architecture that allows for easy extension and maintenance. The core design separates concerns into distinct packages, each with specific responsibilities.

### Architecture Diagram

![TFitPiCAN Architecture](docs/images/architecture_overview.png)

## Core Module Structure

### Environment & Configuration
- **VenvSetup**: Creates and manages the Python virtual environment, installing all dependencies
- **ConfigLoader**: Reads application settings from YAML configuration files
- **ConfigurationManager**: Provides centralized access to application settings

### Simulation Core
- **CANSimulator**: Manages the CAN bus simulation, generating messages and handling timing
- **CarSimulator**: Represents the simulated vehicle with its internal states
- **CANManager**: Coordinates between car simulation and CAN communication
- **CANInterface**: Abstract base class for CAN communication (with Virtual and Hardware implementations)

### User Interface
- **GUIManager**: Initializes and manages the PySide6-based user interface
- **MainWindow**: Main application window with controls and status displays
- **CarView**: Visual representation of the car and its states
- **ScenarioUI**: Interface for scenario selection and control

### Content Management
- **ScenarioManager**: Executes user-selected scenarios
- **ScenarioLoader**: Loads scenario configurations from YAML files
- **LanguageLoader**: Handles multi-language support
- **LibraryLoader**: Dynamically imports external libraries

### Support Systems
- **Logger**: Centralized logging system
- **SelfTest**: Performs integrity and version checks
- **TestLibrary**: Contains automated tests for various components
- **ErrorManager**: Handles error reporting and propagation

## Communication Flow

1. User selects a scenario through the ScenarioUI
2. ScenarioManager loads and executes the scenario
3. CarSimulator updates its internal state based on scenario actions
4. CANSimulator generates corresponding CAN messages
5. CANManager routes messages through the appropriate CANInterface
6. All events are logged through the Logger module
7. The UI is updated to reflect the current state

## Extension Points

TFitPiCAN is designed to be extended in several ways:

1. **New Scenarios**: Add new YAML files to the `scenarios/` directory
2. **New Language Packs**: Add new YAML files to the `languages/` directory
3. **External Libraries**: Add new modules to the `libraries/` directory
4. **Custom CANInterfaces**: Implement new hardware interfaces by extending the CANInterface class

## Architectural Principles

1. **Modularity**: Components are designed with clear interfaces and responsibilities
2. **Configuration Over Code**: Most behavior changes should be possible through YAML configuration
3. **Test-Driven Development**: Each module has corresponding test cases
4. **Error Resilience**: Comprehensive error handling and reporting
5. **Internationalization**: All user-facing text is loaded from language files

For detailed information about specific classes and components, see the class documentation in the [docs/](docs/) directory.
