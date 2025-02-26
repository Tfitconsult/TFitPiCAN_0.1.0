# Package Documentation

This chapter provides detailed documentation for each package in the TFItPiCAN system, including class diagrams, component descriptions, and relationships.

## Table of Contents - Packages

1. [can_bus_support](#can_bus_support-package)
2. [tfitpican_simulator](#tfitpican_simulator-package)
3. [scenarios](#scenarios-package)
4. [scenario_ui](#scenario_ui-package)
5. [logging](#logging-package)
6. [user_management](#user_management-package)
7. [gui](#gui-package)
8. [localization](#localization-package)
9. [error_handling](#error_handling-package)
10. [configuration_management](#configuration_management-package)
11. [testing](#testing-package)
12. [documentation](#documentation-package)

## can_bus_support Package

This package handles the core CAN bus functionality, including message filtering, interpretation, and bus configuration.

```plantuml
@startuml
!define RECTANGLE class

package "can_bus_support" {
  RECTANGLE BusConfiguration {
    - bit_rate: int
    - sample_point: float
    --
    + set_bit_rate(br: int)
    + set_sample_point(sp: float)
    + get_bit_rate() : int
    + get_sample_point() : float
  }

  RECTANGLE CANController {
    - config: BusConfiguration
    - filters: list<CANFilterRule>
    - error_manager: ErrorManager
    --
    + apply_configuration(config: BusConfiguration)
    + add_filter(rule: CANFilterRule)
    + remove_filter(rule: CANFilterRule)
    + process_incoming_message(msg: CANMessage)
    + send_outgoing_message(msg: CANMessage)
    + handle_can_error(error: ErrorEvent)
  }

  RECTANGLE CANFilterRule {
    - id_mask: int
    - id_filter: int
    - data_filter: (CANMessage) -> bool
    --
    + matches(msg: CANMessage) : bool
  }

  RECTANGLE CANMessageInterpreter {
    --
    + interpret_payload(msg: CANMessage) : dict
    + build_message(data: dict) : CANMessage
  }

  RECTANGLE MessageObserver <<interface>> {
    + on_message_received(msg: CANMessage)
  }
}

CANController --> BusConfiguration : uses
CANController --> CANFilterRule : applies filters
CANController --> CANMessageInterpreter : interprets messages
@enduml
```

### BusConfiguration

Handles configuration parameters for the CAN bus communication.

**Attributes:**
- `bit_rate`: int - The bit rate of the CAN bus communication
- `sample_point`: float - The sample point for the CAN bus communication

**Methods:**
- `set_bit_rate(br: int)` - Sets the bit rate
- `set_sample_point(sp: float)` - Sets the sample point
- `get_bit_rate() : int` - Returns the current bit rate
- `get_sample_point() : float` - Returns the current sample point

### CANController

Central component that manages CAN message processing by applying filters and handling both incoming and outgoing messages.

**Attributes:**
- `config`: BusConfiguration - Configuration for the CAN bus
- `filters`: list<CANFilterRule> - List of filter rules to apply to messages
- `error_manager`: ErrorManager - Handles and propagates errors

**Methods:**
- `apply_configuration(config: BusConfiguration)` - Applies a new bus configuration
- `add_filter(rule: CANFilterRule)` - Adds a new filter rule
- `remove_filter(rule: CANFilterRule)` - Removes an existing filter rule
- `process_incoming_message(msg: CANMessage)` - Processes a received message
- `send_outgoing_message(msg: CANMessage)` - Sends a message to the CAN bus
- `handle_can_error(error: ErrorEvent)` - Handles CAN-related errors

### CANFilterRule

Defines filtering rules for CAN messages, allowing selective processing.

**Attributes:**
- `id_mask`: int - Mask to apply to message IDs for filtering
- `id_filter`: int - Value to compare against masked message IDs
- `data_filter`: (CANMessage) -> bool - Optional function for data-based filtering

**Methods:**
- `matches(msg: CANMessage) : bool` - Determines if a message matches the filter

### CANMessageInterpreter

Converts between raw CAN message payloads and structured data dictionaries.

**Methods:**
- `interpret_payload(msg: CANMessage) : dict` - Converts a CAN message payload to a data dictionary
- `build_message(data: dict) : CANMessage` - Creates a CAN message from a data dictionary

### MessageObserver (Interface)

Interface for components that need to observe and react to incoming CAN messages.

**Methods:**
- `on_message_received(msg: CANMessage)` - Called when a new message is received

## tfitpican_simulator Package

This package contains the simulation components for vehicle behavior and CAN communication interfaces.

```plantuml
@startuml
!define RECTANGLE class

package "tfitpican_simulator" {
  RECTANGLE CarSimulator {
    - status: str
    - speed: int
    - doors: int
    --
    + start()
    + stop()
    + update_speed(value: int)
    + emergency_stop()
    + reset_state()
    + handle_error(error: ErrorEvent)
  }

  RECTANGLE CANMessage {
    - message_id: str
    - payload: str
    --
    + create_message(content: str)
  }

  RECTANGLE CANInterface <<abstract>> {
    - connected: bool
    --
    + connect()
    + disconnect()
    + send(can_message: CANMessage)
  }

  RECTANGLE VirtualCANInterface {
    --
    + connect()
    + disconnect()
    + send(can_message: CANMessage)
  }

  RECTANGLE HardwareCANInterface {
    --
    + connect()
    + disconnect()
    + send(can_message: CANMessage)
  }

  RECTANGLE CANManager {
    - error_manager: ErrorManager
    - config_manager: ConfigurationManager
    --
    + initialize_simulator()
    + handle_message(can_message: CANMessage)
    + connect_can()
    + disconnect_can()
    + send_message(can_message: CANMessage)
    + handle_can_error(error: ErrorEvent)
  }

  RECTANGLE SimulatorNetwork {
    - simulators: list<CarSimulator>
    --
    + add_simulator(sim: CarSimulator)
    + remove_simulator(sim: CarSimulator)
    + route_message(can_message: CANMessage, from_sim: CarSimulator)
    + synchronize_states()
  }
}

CANInterface <|-- VirtualCANInterface
CANInterface <|-- HardwareCANInterface
CANManager --> CANInterface : uses
CANManager --> CarSimulator : manages
SimulatorNetwork o-- CarSimulator : contains
@enduml
```

### CarSimulator

Simulates a vehicle, maintaining state (speed, door status, etc.) and handling errors.

**Attributes:**
- `status`: str - Current status of the simulated car
- `speed`: int - Current speed of the simulated car
- `doors`: int - Current state of doors (locked/unlocked)

**Methods:**
- `start()` - Starts the simulator
- `stop()` - Stops the simulator
- `update_speed(value: int)` - Updates the simulated car's speed
- `emergency_stop()` - Simulates an emergency stop
- `reset_state()` - Resets the simulator state
- `handle_error(error: ErrorEvent)` - Handles simulator-related errors

### CANMessage

Represents a CAN message with a unique identifier and associated payload.

**Attributes:**
- `message_id`: str - Identifier for the message
- `payload`: str - Data payload of the message

**Methods:**
- `create_message(content: str)` - Creates a new message with the specified content

### CANInterface (Abstract)

Defines the common interface for both hardware and virtual CAN implementations.

**Attributes:**
- `connected`: bool - Connection status of the interface

**Methods:**
- `connect()` - Establishes connection
- `disconnect()` - Terminates connection
- `send(can_message: CANMessage)` - Sends a message through the interface

### VirtualCANInterface

A simulated CAN interface used for testing and simulation purposes.

**Methods:**
- `connect()` - Simulates connecting to a virtual CAN bus
- `disconnect()` - Simulates disconnecting from a virtual CAN bus
- `send(can_message: CANMessage)` - Simulates sending a CAN message

### HardwareCANInterface

Implements the CAN interface for hardware-based operations, connecting to actual CAN hardware.

**Methods:**
- `connect()` - Connects to the physical CAN hardware
- `disconnect()` - Disconnects from the physical CAN hardware
- `send(can_message: CANMessage)` - Sends a message through the physical CAN interface

### CANManager

Coordinates CAN communications between simulators and CAN interfaces, integrating error and configuration management.

**Attributes:**
- `error_manager`: ErrorManager - For error handling
- `config_manager`: ConfigurationManager - For CAN configuration

**Methods:**
- `initialize_simulator()` - Sets up the simulation environment
- `handle_message(can_message: CANMessage)` - Processes incoming CAN messages
- `connect_can()` - Establishes a CAN connection
- `disconnect_can()` - Terminates the CAN connection
- `send_message(can_message: CANMessage)` - Sends a message to the CAN bus
- `handle_can_error(error: ErrorEvent)` - Handles CAN-related errors

### SimulatorNetwork

Manages a collection of simulators, routing messages among them and synchronizing their states.

**Attributes:**
- `simulators`: list<CarSimulator> - List of connected simulators

**Methods:**
- `add_simulator(sim: CarSimulator)` - Adds a simulator to the network
- `remove_simulator(sim: CarSimulator)` - Removes a simulator from the network
- `route_message(can_message: CANMessage, from_sim: CarSimulator)` - Routes messages between simulators
- `synchronize_states()` - Ensures all simulators have consistent states

## scenarios Package

This package provides various simulation scenarios and management of these scenarios.

```plantuml
@startuml
!define RECTANGLE class

package "scenarios" {
  RECTANGLE Scenario <<abstract>> {
    - name: str
    - description: str
    --
    + start_scenario(simulator: CarSimulator)
    + stop_scenario(simulator: CarSimulator)
    + get_name() : str
    + get_description() : str
  }

  RECTANGLE FrontCollisionScenario {
    --
    + start_scenario(simulator: CarSimulator)
    + stop_scenario(simulator: CarSimulator)
  }

  RECTANGLE IceOnWheelScenario {
    --
    + start_scenario(simulator: CarSimulator)
    + stop_scenario(simulator: CarSimulator)
  }

  RECTANGLE ScenarioManager {
    - scenarios: list<Scenario>
    - active_scenario: Scenario
    - scenario_status: dict<Scenario, str>
    --
    + register_scenario(scenario: Scenario)
    + load_scenario(name: str)
    + run_scenario(simulator: CarSimulator)
    + stop_scenario(simulator: CarSimulator)
    + reset_all(simulator: CarSimulator)
    + get_scenario_status(scenario: Scenario) : str
  }
}

Scenario <|-- FrontCollisionScenario
Scenario <|-- IceOnWheelScenario
ScenarioManager o-- Scenario : manages
@enduml
```

### Scenario (Abstract)

Abstract base class for simulation scenarios.

**Attributes:**
- `name`: str - Name of the scenario
- `description`: str - Description of the scenario

**Methods:**
- `start_scenario(simulator: CarSimulator)` - Initiates the scenario
- `stop_scenario(simulator: CarSimulator)` - Stops the scenario
- `get_name() : str` - Returns the scenario name
- `get_description() : str` - Returns the scenario description

### FrontCollisionScenario

Simulates a front collision scenario.

**Methods:**
- `start_scenario(simulator: CarSimulator)` - Starts the front collision scenario
- `stop_scenario(simulator: CarSimulator)` - Stops the front collision scenario

### IceOnWheelScenario

Simulates a scenario where ice causes a loss of traction.

**Methods:**
- `start_scenario(simulator: CarSimulator)` - Starts the ice on wheel scenario
- `stop_scenario(simulator: CarSimulator)` - Stops the ice on wheel scenario

### ScenarioManager

Manages the registration, execution, and status of simulation scenarios.

**Attributes:**
- `scenarios`: list<Scenario> - Available scenarios
- `active_scenario`: Scenario - Currently active scenario
- `scenario_status`: dict<Scenario, str> - Status of each scenario (Running, Stopped, etc.)

**Methods:**
- `register_scenario(scenario: Scenario)` - Adds a scenario to the manager
- `load_scenario(name: str)` - Loads a scenario by name
- `run_scenario(simulator: CarSimulator)` - Executes the active scenario
- `stop_scenario(simulator: CarSimulator)` - Stops the active scenario
- `reset_all(simulator: CarSimulator)` - Resets all scenarios
- `get_scenario_status(scenario: Scenario) : str` - Gets the status of a scenario

## scenario_ui Package

This package provides the user interface components for interacting with scenarios.

```plantuml
@startuml
!define RECTANGLE class

package "scenario_ui" {
  RECTANGLE ScenarioUI <<interface>> {
    + list_scenarios() : list<str>
    + select_scenario(name: str)
    + run_selected_scenario(simulator: CarSimulator)
    + stop_current_scenario(simulator: CarSimulator)
    + refresh_language()
  }

  RECTANGLE ScenarioTab {
    - scenario_names: list<str>
    - selected_scenario_name: str
    - scenario_manager: ScenarioManager
    --
    + list_scenarios() : list<str>
    + select_scenario(name: str)
    + run_selected_scenario(simulator: CarSimulator)
    + stop_current_scenario(simulator: CarSimulator)
    + refresh_language()
  }
}

ScenarioUI <|.. ScenarioTab : implements
@enduml
```

### ScenarioUI (Interface)

Interface for user interface components that manage scenarios.

**Methods:**
- `list_scenarios() : list<str>` - Lists available scenarios
- `select_scenario(name: str)` - Selects a scenario by name
- `run_selected_scenario(simulator: CarSimulator)` - Executes the selected scenario
- `stop_current_scenario(simulator: CarSimulator)` - Stops the current scenario
- `refresh_language()` - Updates UI language based on localization settings

### ScenarioTab

A concrete implementation of the ScenarioUI interface for a tabbed interface.

**Attributes:**
- `scenario_names`: list<str> - Names of available scenarios
- `selected_scenario_name`: str - Currently selected scenario
- `scenario_manager`: ScenarioManager - Reference to the scenario manager

**Methods:**
- `list_scenarios() : list<str>` - Lists available scenarios
- `select_scenario(name: str)` - Selects a scenario by name
- `run_selected_scenario(simulator: CarSimulator)` - Runs the selected scenario
- `stop_current_scenario(simulator: CarSimulator)` - Stops the current scenario
- `refresh_language()` - Updates the tab's language

## logging Package

This package provides logging functionality for the system.

```plantuml
@startuml
!define RECTANGLE class

package "logging" {
  RECTANGLE LoggingInterface <<interface>> {
    + log_message(can_message: CANMessage)
    + log_event(event: str, level: str = "INFO")
    + get_logs() : list<CANMessage>
    + clear_logs()
  }

  RECTANGLE LoggingSystem {
    - message_log: list<CANMessage>
    - scenario_log: list<str>
    --
    + log_message(can_message: CANMessage)
    + log_event(event: str, level: str = "INFO")
    + get_logs()
    + clear_logs()
  }

  RECTANGLE LogFileHandler {
    - log_file_path: str
    --
    + write_message_to_file(can_message: CANMessage)
    + write_event_to_file(event: str)
    + read_logs() : list<str>
    + clear_log_file()
  }
}

LoggingInterface <|.. LoggingSystem : implements
LoggingSystem --> LogFileHandler : uses
@enduml
```

### LoggingInterface (Interface)

Interface that defines the operations for logging systems.

**Methods:**
- `log_message(can_message: CANMessage)` - Logs a CAN message
- `log_event(event: str, level: str = "INFO")` - Logs an event with a specified level
- `get_logs() : list<CANMessage>` - Retrieves logged messages
- `clear_logs()` - Clears the logs

### LoggingSystem

Centralized logging system implementing the LoggingInterface.

**Attributes:**
- `message_log`: list<CANMessage> - Log of CAN messages
- `scenario_log`: list<str> - Log of scenario events

**Methods:**
- `log_message(can_message: CANMessage)` - Logs a CAN message
- `log_event(event: str, level: str = "INFO")` - Logs an event
- `get_logs()` - Retrieves all logs
- `clear_logs()` - Clears all logs

### LogFileHandler

Handles file I/O for logging purposes.

**Attributes:**
- `log_file_path`: str - Path to the log file

**Methods:**
- `write_message_to_file(can_message: CANMessage)` - Writes a message to the log file
- `write_event_to_file(event: str)` - Writes an event to the log file
- `read_logs() : list<str>` - Reads logs from the file
- `clear_log_file()` - Clears the log file
