\"\"\"
License: MIT
Author: Thomas Fischer
File: scenario_manager.py
Version: 0.1.0
Description: Manages and runs scenarios (e.g., front-collision, ice on wheel)
\"\"\"

class ScenarioManager:
    def load_scenario(self, name):
        print(f"Scenario '{name}' loaded")

    def run_scenario(self):
        print("Scenario running...")

    def stop_scenario(self):
        print("Scenario stopped")
