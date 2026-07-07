# TFitPiCAN Module Structure

- **Author:** Thomas Fischer
- **Version:** 0.1.0
- **Filename:** MODULES.md
- **Filetype:** Markdown
- **Description:** Documentation of the module structure for TFitPiCAN CAN-Bus Simulator

## Package Overview

TFitPiCAN is organized into several logical packages, each containing related classes:

### CAN Bus Support (`can_bus_support`)

Classes for CAN bus configuration, message handling, and filtering:

- `BusConfiguration`: Manages CAN bus parameters (bit rate, sample point)
- `CANController`: Core controller for CAN message processing
- `CANFilterRule`: Rules for filtering CAN messages
- `CANMessageInterpreter`: Translates between raw CAN messages and structured data
- `MessageObserver`: Interface for components that need to receive CAN messages

### Simulator Core (`tfitpican_simulator`)

Core classes for the simulation:

- `CarSimulator`: Manages the simulated car's state
- `CANMessage`: Represents a CAN message
- `CANInterface`: Abstract interface for CAN communication
- `VirtualCANInterface`: Software-only implementation of CAN
- `HardwareCANInterface`: Hardware-backed implementation of CAN
- `CANManager`: Manages CAN communication and errors
- `SimulatorNetwork`: Connects multiple simulators for network simulation

### Scenarios (`scenarios`)

Scenario management and implementations:

- `Scenario`: Abstract base class for scenarios
- `FrontCollisionScenario`: Simulates a front collision
- `IceOnWheelScenario`: Simulates ice on wheel conditions
- `ScenarioManager`: Manages scenario loading and execution

### Scenario UI (`scenario_ui`)

UI components for scenario management:

- `ScenarioUI`: Interface for scenario UI components
- `ScenarioTab`: Tab-based UI implementation for scenarios

### Logging (`logging`)

Logging system and interfaces:

- `LoggingInterface`: Interface for logging components
- `LoggingSystem`: Implementation of the logging system
- `LogFileHandler`: Manages log file operations

### User Management (`user_management`)

User classes and management:

- `User`: Represents a user with permissions
- `UserManager`: Manages users and authentication

### GUI (`gui`)

Main GUI components:

- `MainWindow`: Main application window
- `CarView`: Visual representation of the car
- `CustomButton`: Customized button with additional functionality
- `UserPanel`: Panel for user management in the UI

### Localization (`localization`)

Language handling:

- `LocalizationManager`: Manages language files and translations

### Error Handling (`error_handling`)

Error management classes:

- `ErrorEvent`: Represents an error event
- `ErrorPropagationInterface`: Interface for error handling
- `ErrorManager`: Centralized error management

### Configuration Management (`configuration_management`)

Configuration interfaces and management:

- `ConfigurationInterface`: Interface for configuration components
- `ConfigurationManager`: Manages application configuration
- `ConfigFileHandler`: Handles configuration file operations

### Testing (`testing`)

Test framework classes:

- `TestRunner`: Runs test suites
- `TestSuite`: Abstract base class for test suites
- `UnitTest`: Unit test implementation
- `IntegrationTest`: Integration test implementation
- `MockCANInterface`: Mock CAN interface for testing
- `MockCarSimulator`: Mock car simulator for testing

### Documentation (`documentation`)

Documentation generation:

- `DocumentationGenerator`: Generates documentation from code and configuration

## Module Relationships

![Module Relationships](images/module_relationships.png)

The diagram above shows the main relationships between modules. Key points:

1. The `CANManager` is the central hub connecting the simulator with CAN interfaces
2. The `ScenarioManager` orchestrates scenarios and communicates with both the car simulator and UI
3. The `LoggingSystem` provides logging services to all other modules
4. The `ConfigurationManager` provides configuration to all components
5. The `ErrorManager` handles error reporting and propagation

## File Organization

Within the source directory, files are organized by package. Each package has its own directory with related class files:

```
src/
├── can_bus_support/
│   ├── __init__.py
│   ├── bus_configuration.py
│   ├── can_controller.py
│   ├── can_filter_rule.py
│   ├── can_message_interpreter.py
│   └── message_observer.py
├── tfitpican_simulator/
│   ├── __init__.py
│   ├── car_simulator.py
│   ├── can_message.py
│   ├── can_interface.py
│   ├── virtual_can_interface.py
│   ├── hardware_can_interface.py
│   ├── can_manager.py
│   └── simulator_network.py
├── ...
```

Each module follows a consistent file naming convention and structure to ensure maintainability.
