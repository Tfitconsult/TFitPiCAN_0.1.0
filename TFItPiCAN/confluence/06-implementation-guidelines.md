# Implementation Guidelines

This chapter provides guidelines for implementing the TFItPiCAN system according to the architecture. These guidelines ensure consistency, maintainability, and quality throughout the codebase.

## Python Best Practices

### Code Style

1. **PEP 8 Compliance**
   - Follow PEP 8 style guide for Python code
   - Use flake8 for style checking
   - Maintain 4-space indentation throughout the codebase

2. **Type Hints**
   - Use type hints for all function parameters and return values
   - Use mypy for static type checking
   - Define clear interfaces with Protocol classes where appropriate

3. **Docstrings**
   - Document all classes, methods, and functions with docstrings
   - Follow Google docstring style for consistency
   - Include parameter descriptions, return values, and exceptions

Example of well-styled code:

```python
"""
TFItPiCAN - CAN Bus Interface and Simulator

Version: 0.1.0
Author: Thomas Fischer
License: MIT

Description: 
Example implementation of a CAN filter rule.
"""
from typing import Callable, Optional
from .can_message import CANMessage


class CANFilterRule:
    """
    Defines filtering rules for CAN messages.
    
    Filters messages based on ID mask, ID filter, and optional data-based filtering.
    """
    
    def __init__(
        self, 
        id_mask: int, 
        id_filter: int, 
        data_filter: Optional[Callable[[CANMessage], bool]] = None
    ) -> None:
        """
        Initialize a new CAN filter rule.
        
        Args:
            id_mask: Mask to apply to message IDs for filtering
            id_filter: Value to compare against masked message IDs
            data_filter: Optional function for data-based filtering
        """
        self.id_mask = id_mask
        self.id_filter = id_filter
        self.data_filter = data_filter
    
    def matches(self, msg: CANMessage) -> bool:
        """
        Determine if a message matches the filter.
        
        Args:
            msg: The CAN message to check against the filter
            
        Returns:
            True if the message matches the filter, False otherwise
        """
        # Apply mask and check against filter
        if (int(msg.message_id, 16) & self.id_mask) != self.id_filter:
            return False
            
        # If data filter exists, apply it
        if self.data_filter is not None:
            return self.data_filter(msg)
            
        return True
```

### Error Handling

1. **Exception Hierarchy**
   - Create a custom exception hierarchy for the application
   - Define specific exception types for different error categories
   - Use exception chaining to preserve context

2. **Error Propagation**
   - Use Python's exception mechanism for error propagation
   - Catch exceptions at appropriate boundaries
   - Properly log exceptions with context

3. **Resource Management**
   - Use context managers (`with` statements) for resource management
   - Ensure proper cleanup in `__exit__` methods
   - Handle cleanup in both success and failure cases

Example error handling structure:

```python
class TFItPiCANError(Exception):
    """Base exception for all TFItPiCAN errors."""
    pass


class CANError(TFItPiCANError):
    """Base exception for CAN-related errors."""
    pass


class CANConnectionError(CANError):
    """Error when connecting to CAN interface."""
    pass


class CANMessageError(CANError):
    """Error with CAN message format or processing."""
    pass


def connect_can_interface(interface_type: str) -> CANInterface:
    """
    Connect to a CAN interface.
    
    Args:
        interface_type: Type of interface to connect to
        
    Returns:
        Connected CAN interface
        
    Raises:
        CANConnectionError: If connection fails
    """
    try:
        if interface_type == "virtual":
            interface = VirtualCANInterface()
        elif interface_type == "hardware":
            interface = HardwareCANInterface()
        else:
            raise ValueError(f"Unknown interface type: {interface_type}")
        
        interface.connect()
        return interface
    except ValueError as e:
        # Convert to application-specific exception
        raise CANConnectionError(f"Invalid interface configuration") from e
    except Exception as e:
        # Handle unexpected errors
        raise CANConnectionError(f"Failed to connect to {interface_type} interface") from e
```

### Testing Strategy

1. **Unit Testing**
   - Write unit tests for all components
   - Use pytest as the testing framework
   - Aim for high test coverage (>80%)

2. **Integration Testing**
   - Create integration tests for component interactions
   - Use test fixtures for common setup/teardown
   - Mock external dependencies appropriately

3. **Test Organization**
   - Match test directory structure to source structure
   - Name test files with `test_` prefix
   - Group tests by functionality

Example test organization:

```
tests/
├── unit/
│   ├── can_bus_support/
│   │   ├── test_bus_configuration.py
│   │   ├── test_can_controller.py
│   │   └── test_can_filter_rule.py
│   └── ...
├── integration/
│   ├── test_can_scenario_integration.py
│   └── ...
└── conftest.py
```

## GUI Implementation

### PyQt Best Practices

1. **Model-View-Controller Pattern**
   - Separate UI components from business logic
   - Use PyQt's model classes for data representation
   - Connect signals and slots for event handling

2. **UI Design**
   - Design responsive UIs that work on different screen sizes
   - Use Qt Designer for layout design
   - Separate UI definitions from logic implementation

3. **Performance Considerations**
   - Optimize UI update frequency
   - Use background threads for long-running operations
   - Implement efficient rendering for CarView

Example MVC implementation:

```python
class SpeedModel(QObject):
    """Model for vehicle speed data."""
    speed_changed = pyqtSignal(int)
    
    def __init__(self):
        super().__init__()
        self._speed = 0
        
    def set_speed(self, value: int) -> None:
        """Update the speed value."""
        if self._speed != value:
            self._speed = value
            self.speed_changed.emit(value)
            
    def get_speed(self) -> int:
        """Get the current speed value."""
        return self._speed


class SpeedController:
    """Controller for speed-related operations."""
    
    def __init__(self, model: SpeedModel, simulator: CarSimulator):
        self.model = model
        self.simulator = simulator
        
    def update_speed(self, value: int) -> None:
        """Update the speed in both model and simulator."""
        self.simulator.update_speed(value)
        self.model.set_speed(value)
        
    def emergency_stop(self) -> None:
        """Perform emergency stop."""
        self.simulator.emergency_stop()
        self.model.set_speed(0)


class SpeedView(QWidget):
    """View for displaying and controlling speed."""
    
    def __init__(self, model: SpeedModel, controller: SpeedController):
        super().__init__()
        self.model = model
        self.controller = controller
        
        # Set up UI
        self.speed_display = QLabel("0")
        self.speed_slider = QSlider(Qt.Horizontal)
        self.emergency_button = QPushButton("STOP")
        
        # Layout
        layout = QVBoxLayout()
        layout.addWidget(self.speed_display)
        layout.addWidget(self.speed_slider)
        layout.addWidget(self.emergency_button)
        self.setLayout(layout)
        
        # Connect signals
        self.model.speed_changed.connect(self.update_speed_display)
        self.speed_slider.valueChanged.connect(self.controller.update_speed)
        self.emergency_button.clicked.connect(self.controller.emergency_stop)
        
    def update_speed_display(self, speed: int) -> None:
        """Update the speed display label."""
        self.speed_display.setText(str(speed))
```

### Localization Implementation

1. **Translation Management**
   - Store translations in JSON or YAML files
   - Implement the LocalizationManager to handle translation retrieval
   - Support runtime language switching

2. **UI Integration**
   - Update all UI elements when language changes
   - Use parameterized translations for dynamic content
   - Consider right-to-left language support

Example localization implementation:

```python
class LocalizationManager:
    """Manages translations and language settings."""
    
    def __init__(self, default_language: str = "en"):
        self.current_language = default_language
        self.translations = {}
        
    def load_translations(self, file_path: str) -> None:
        """Load translations from a file."""
        with open(file_path, 'r') as f:
            self.translations = json.load(f)
            
    def set_language(self, language: str) -> None:
        """Set the active language."""
        if language in self.translations:
            self.current_language = language
        else:
            raise ValueError(f"Language {language} not available")
            
    def get_translation(self, key: str, default: str = None) -> str:
        """Get a translation for a key."""
        try:
            return self.translations[self.current_language][key]
        except KeyError:
            # Fall back to default language if translation missing
            try:
                if default:
                    return default
                return self.translations["en"][key]
            except KeyError:
                # Return the key itself if no translation found
                return key
```

## CAN Implementation

### Using python-can

1. **Bus Configuration**
   - Configure the CAN bus using python-can's interface
   - Support different bit rates and sample points
   - Abstract bus configuration through BusConfiguration class

2. **Message Handling**
   - Use python-can's Message class as the foundation for CANMessage
   - Implement proper serialization and deserialization
   - Handle different message formats (standard, extended, RTR)

3. **Interface Implementation**
   - Create adapter classes for python-can interfaces
   - Implement proper error handling for hardware failures
   - Support hot-plugging of CAN interfaces where possible

Example python-can integration:

```python
import can
from typing import Optional
from .can_message import CANMessage
from .interfaces import CANInterface


class HardwareCANInterface(CANInterface):
    """Hardware implementation of the CAN interface using python-can."""
    
    def __init__(self, channel: str = "can0", bitrate: int = 500000):
        super().__init__()
        self.channel = channel
        self.bitrate = bitrate
        self.bus: Optional[can.BusABC] = None
        self.connected = False
        
    def connect(self) -> None:
        """Connect to the CAN hardware interface."""
        try:
            self.bus = can.interface.Bus(
                channel=self.channel,
                bustype='socketcan',
                bitrate=self.bitrate
            )
            self.connected = True
        except can.CanError as e:
            self.connected = False
            raise CANConnectionError(f"Failed to connect to {self.channel}") from e
            
    def disconnect(self) -> None:
        """Disconnect from the CAN hardware interface."""
        if self.bus:
            self.bus.shutdown()
            self.bus = None
        self.connected = False
        
    def send(self, can_message: CANMessage) -> None:
        """Send a message through the CAN interface."""
        if not self.connected or not self.bus:
            raise CANConnectionError("Not connected to CAN interface")
            
        # Convert CANMessage to python-can Message
        message = can.Message(
            arbitration_id=int(can_message.message_id, 16),
            data=bytes.fromhex(can_message.payload),
            is_extended_id=len(can_message.message_id) > 3
        )
        
        try:
            self.bus.send(message)
        except can.CanError as e:
            raise CANMessageError("Failed to send message") from e
```

### Simulation Implementation

1. **Virtual CAN Interface**
   - Implement a memory-based virtual CAN interface
   - Simulate realistic CAN bus behavior
   - Support filtering and message routing

2. **CarSimulator**
   - Model vehicle state accurately
   - Implement realistic behavior for scenarios
   - Provide hooks for scenario intervention

3. **Network Simulation**
   - Create a simulated network of multiple simulators
   - Implement message routing between simulators
   - Support synchronization of state

Example simulator implementation:

```python
from datetime import datetime
from typing import Dict, List, Optional
from .can_message import CANMessage


class CarSimulator:
    """Simulates a vehicle with state and behavior."""
    
    def __init__(self, simulator_id: str):
        self.simulator_id = simulator_id
        self.status = "STOPPED"
        self.speed = 0
        self.doors_locked = False
        self.error_manager = None
        
    def set_error_manager(self, error_manager) -> None:
        """Set the error manager for this simulator."""
        self.error_manager = error_manager
        
    def start(self) -> None:
        """Start the simulator."""
        if self.status != "RUNNING":
            self.status = "RUNNING"
            
    def stop(self) -> None:
        """Stop the simulator."""
        if self.status != "STOPPED":
            self.status = "STOPPED"
            self.speed = 0
            
    def update_speed(self, value: int) -> None:
        """Update the simulated car's speed."""
        if self.status != "RUNNING":
            return
            
        # Apply realistic acceleration limits
        max_change = 5  # max 5 units change per update
        if abs(value - self.speed) > max_change:
            if value > self.speed:
                self.speed += max_change
            else:
                self.speed -= max_change
        else:
            self.speed = value
            
    def emergency_stop(self) -> None:
        """Simulate an emergency stop."""
        self.speed = 0
        
    def reset_state(self) -> None:
        """Reset the simulator state."""
        self.stop()
        self.doors_locked = False
        
    def handle_error(self, error) -> None:
        """Handle simulator-related errors."""
        if self.error_manager:
            self.error_manager.report_error(error)
            
        # Take action based on error severity
        if error.get_severity() == "CRITICAL":
            self.emergency_stop()
```

## Configuration and Deployment

### Configuration Management

1. **Configuration Storage**
   - Use YAML for human-readable configuration
   - Implement schema validation for configurations
   - Support environment-specific configurations

2. **Dynamic Configuration**
   - Implement observers for configuration changes
   - Support hot reload of configuration
   - Validate configuration changes before applying

3. **Default Configuration**
   - Provide sensible defaults for all options
   - Document all configuration parameters
   - Include sample configurations for common scenarios

Example configuration implementation:

```python
import yaml
import os
from typing import Any, Dict, Optional
from pathlib import Path


class ConfigFileHandler:
    """Handles reading from and writing to configuration files."""
    
    def __init__(self, config_path: str):
        self.config_path = Path(config_path)
        
    def read_config(self) -> Dict[str, Any]:
        """Read configuration from file."""
        if not self.config_path.exists():
            return {}
            
        with open(self.config_path, 'r') as f:
            try:
                return yaml.safe_load(f) or {}
            except yaml.YAMLError as e:
                raise ConfigurationError(f"Invalid configuration file: {e}")
                
    def write_config(self, settings: Dict[str, Any]) -> None:
        """Write configuration to file."""
        # Ensure directory exists
        self.config_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(self.config_path, 'w') as f:
            yaml.dump(settings, f, default_flow_style=False)
```

### Deployment Process

1. **Package Creation**
   - Create deployable packages with Poetry
   - Include all dependencies and configurations
   - Generate platform-specific packages

2. **Installation Scripts**
   - Provide installation scripts for Raspberry Pi
   - Include system service configuration for autostart
   - Set up necessary permissions and system dependencies

3. **Update Process**
   - Design a clear update process for deployed systems
   - Include version migration scripts
   - Implement backup and restore functionality

Example deployment script:

```bash
#!/bin/bash
# deploy_to_pi.sh - Deploy TFItPiCAN to Raspberry Pi

# Configuration
PI_HOST="raspberrypi.local"
PI_USER="pi"
DEPLOY_DIR="/home/pi/tfitpican"
SERVICE_NAME="tfitpican"

# Build package
echo "Building package..."
poetry build

# Create deployment package
echo "Creating deployment package..."
mkdir -p deploy
cp dist/*.whl deploy/
cp scripts/install_on_pi.sh deploy/
cp config/tfitpican.service deploy/
cp config/config.yaml deploy/

# Transfer to Raspberry Pi
echo "Deploying to Raspberry Pi at ${PI_HOST}..."
scp -r deploy ${PI_USER}@${PI_HOST}:${DEPLOY_DIR}

# Run installation script
echo "Installing on Raspberry Pi..."
ssh ${PI_USER}@${PI_HOST} "cd ${DEPLOY_DIR} && bash install_on_pi.sh"

echo "Deployment complete!"
```

## Documentation Guidelines

1. **Code Documentation**
   - Document all public APIs with docstrings
   - Include usage examples where appropriate
   - Document design decisions and trade-offs

2. **System Documentation**
   - Generate system documentation from code
   - Create architecture diagrams with PlantUML
   - Maintain user and developer guides

3. **Documentation Process**
   - Update documentation with code changes
   - Review documentation during code review
   - Automate documentation generation where possible

Example documentation generation:

```python
from pathlib import Path
import inspect
import importlib
import pkgutil
import tfitpican


class DocumentationGenerator:
    """Generates project documentation including markdown and diagrams."""
    
    def __init__(self):
        self.root_package = tfitpican
        
    def generate_markdown_docs(self, output_path: str) -> None:
        """Generate markdown documentation for the project."""
        output_dir = Path(output_path)
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # Generate package documentation
        for package in self._get_packages():
            self._document_package(package, output_dir)
            
    def _get_packages(self):
        """Get all packages in the project."""
        packages = []
        for _, name, is_pkg in pkgutil.iter_modules(self.root_package.__path__):
            if is_pkg:
                packages.append(importlib.import_module(f"{self.root_package.__name__}.{name}"))
        return packages
        
    def _document_package(self, package, output_dir):
        """Generate documentation for a package."""
        package_name = package.__name__.split('.')[-1]
        doc_file = output_dir / f"{package_name}.md"
        
        with open(doc_file, 'w') as f:
            f.write(f"# {package_name} Package\n\n")
            f.write(f"{package.__doc__ or ''}\n\n")
            
            # Document classes in the package
            for name, obj in inspect.getmembers(package):
                if inspect.isclass(obj) and obj.__module__ == package.__name__:
                    f.write(f"## {name}\n\n")
                    f.write(f"{obj.__doc__ or ''}\n\n")
                    
                    # Document methods
                    for method_name, method in inspect.getmembers(obj, inspect.isfunction):
                        if not method_name.startswith('_'):
                            f.write(f"### {method_name}\n\n")
                            f.write(f"{method.__doc__ or ''}\n\n")
```
