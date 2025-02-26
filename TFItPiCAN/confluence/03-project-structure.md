# Project Structure

The TFItPiCAN project follows a standardized directory structure designed to organize code logically and support effective development workflows.

## Directory Structure

```
TFItPiCAN/
├── .github/                      # GitHub workflows and issue templates
├── docs/                         # Documentation for GitHub Pages
├── jira/                         # Jira-related files
│   └── init.csv                  # CSV import file for initial Jira tasks
├── src/
│   └── tfitpican/                # Main package
│       ├── __init__.py           # Version information
│       ├── can_bus_support/      # CAN bus core functionality
│       ├── tfitpican_simulator/  # Simulation components
│       ├── scenarios/            # Scenario definitions
│       ├── scenario_ui/          # UI for scenarios
│       ├── logging/              # Logging infrastructure
│       ├── user_management/      # User authentication
│       ├── gui/                  # Qt GUI components
│       ├── localization/         # Multi-language support
│       ├── error_handling/       # Error framework
│       ├── configuration/        # Configuration management
│       ├── testing/              # Test infrastructure
│       └── documentation/        # Documentation generator
├── tests/                        # Test suite
├── pyproject.toml               # Poetry configuration
├── README.md                    # Project overview
└── LICENSE                      # MIT license text
```

## File Naming Conventions

TFItPiCAN follows these naming conventions:

1. **Python Modules**: Snake case (lowercase with underscores)
   - Example: `can_controller.py`, `error_manager.py`

2. **Python Classes**: CamelCase (PascalCase)
   - Example: `class CANController`, `class ErrorManager`

3. **Python Methods and Functions**: Snake case
   - Example: `process_incoming_message()`, `handle_can_error()`

4. **Constants**: UPPER_SNAKE_CASE
   - Example: `MAX_MESSAGE_SIZE`, `DEFAULT_BIT_RATE`

5. **Configuration Files**: lowercase with extension
   - Example: `config.yaml`, `translations.json`

## Source File Header Template

Every source file in the TFItPiCAN project must include the following header:

```python
"""
TFItPiCAN - CAN Bus Interface and Simulator

Version: 0.1.0
Author: Thomas Fischer
License: MIT

Description: 
[Brief description of the file's purpose]
"""
```

## Versioning

TFItPiCAN follows these versioning rules:

1. Start at version 0.1.0
2. Each change increments the patch version (e.g., 0.1.0 → 0.1.1)
3. Patch versions can go up to 0.1.999
4. Minor version increments (0.1.x → 0.2.0) are reserved for significant feature additions
5. Major version increments (0.x.y → 1.0.0) are reserved for API-breaking changes

## Package Organization

Each package under `src/tfitpican/` follows a consistent internal structure:

```
package_name/
├── __init__.py       # Package initialization and version
├── interfaces.py     # Abstract interfaces (if applicable)
├── models.py         # Data models and structures
├── exceptions.py     # Package-specific exceptions
└── components/       # Individual component modules
```

## Testing Structure

The `tests/` directory mirrors the structure of the `src/` directory:

```
tests/
├── unit/             # Unit tests for individual components
├── integration/      # Tests for component interactions
├── system/           # End-to-end system tests
└── conftest.py       # Common test fixtures and utilities
```

## Configuration Files

Configuration files are stored in a platform-specific location:

- **Development (Mac)**: `~/Library/Application Support/TFItPiCAN/`
- **Deployment (Raspberry Pi)**: `/etc/tfitpican/`

## Documentation Resources

The `docs/` directory contains the following resources:

```
docs/
├── api/              # API documentation
├── user_guide/       # End-user documentation
├── developer_guide/  # Developer reference
└── assets/           # Images and other assets
```

This documentation is published to GitHub Pages for public access.
