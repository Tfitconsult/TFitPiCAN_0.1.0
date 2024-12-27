#!/bin/bash

# init_tfitpican.sh
# Creates the TFitPiCAN_0.1.0 folder structure and initial files.

VERSION="0.1.0"
PROJECT="TFitPiCAN_${VERSION}"

echo "Creating project: $PROJECT"

# Create folders
mkdir -p "$PROJECT"/src/tfitpican_simulator
mkdir -p "$PROJECT"/src/gui
mkdir -p "$PROJECT"/src/scenarios
mkdir -p "$PROJECT"/tests
mkdir -p "$PROJECT"/docs

# Create README
cat <<EOF > "$PROJECT/README.md"
# TFitPiCAN (Version $VERSION)

A Raspberry Pi CAN-Bus simulator application.

## License
MIT

## Author
Thomas Fischer

## Overview
This project simulates and visualizes CAN-bus messages on a Raspberry Pi.

EOF

# Create requirements.txt
cat <<EOF > "$PROJECT/requirements.txt"
# Dependencies for TFitPiCAN
PySide6==6.x.x
EOF

# Create main.py
cat <<EOF > "$PROJECT/src/main.py"
#!/usr/bin/env python3
\"\"\"
License: MIT
Author: Thomas Fischer
File: main.py
Version: $VERSION
Description: Entry point for TFitPiCAN simulator
\"\"\"

def main():
    print("Running TFitPiCAN version $VERSION")

if __name__ == "__main__":
    main()
EOF

# Create can_sim.py
cat <<EOF > "$PROJECT/src/tfitpican_simulator/can_sim.py"
\"\"\"
License: MIT
Author: Thomas Fischer
File: can_sim.py
Version: $VERSION
Description: Core CAN simulator logic
\"\"\"

class CANBusSimulator:
    def __init__(self):
        self.status = "Stopped"
        self.speed = 0
        self.doors = 0

    def start(self):
        self.status = "Running"
        print("Simulator started")

    def stop(self):
        self.status = "Stopped"
        print("Simulator stopped")
EOF

# Create can_manager.py
cat <<EOF > "$PROJECT/src/tfitpican_simulator/can_manager.py"
\"\"\"
License: MIT
Author: Thomas Fischer
File: can_manager.py
Version: $VERSION
Description: Manages CAN connections and messages
\"\"\"

class CANManager:
    def __init__(self, simulator):
        self.simulator = simulator

    def connect_can(self):
        print("CAN interface connected")

    def disconnect_can(self):
        print("CAN interface disconnected")

    def handle_message(self, message):
        print(f"Handling message: {message}")
EOF

# Create scenario_manager.py
cat <<EOF > "$PROJECT/src/scenarios/scenario_manager.py"
\"\"\"
License: MIT
Author: Thomas Fischer
File: scenario_manager.py
Version: $VERSION
Description: Manages and runs scenarios (e.g., front-collision, ice on wheel)
\"\"\"

class ScenarioManager:
    def load_scenario(self, name):
        print(f"Scenario '{name}' loaded")

    def run_scenario(self):
        print("Scenario running...")

    def stop_scenario(self):
        print("Scenario stopped")
EOF

# Create a simple test file
cat <<EOF > "$PROJECT/tests/test_can_sim.py"
\"\"\"
License: MIT
Author: Thomas Fischer
File: test_can_sim.py
Version: $VERSION
Description: Basic unit tests for CANBusSimulator
\"\"\"

import unittest
from src.tfitpican_simulator.can_sim import CANBusSimulator

class TestCANBusSimulator(unittest.TestCase):
    def test_start(self):
        sim = CANBusSimulator()
        sim.start()
        self.assertEqual(sim.status, "Running")

    def test_stop(self):
        sim = CANBusSimulator()
        sim.stop()
        self.assertEqual(sim.status, "Stopped")

if __name__ == '__main__':
    unittest.main()
EOF

# Done
echo "Project structure created for TFitPiCAN_$VERSION."
echo "You can now open the folder '$PROJECT' and start coding!"

