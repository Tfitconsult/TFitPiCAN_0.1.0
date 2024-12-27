\"\"\"
License: MIT
Author: Thomas Fischer
File: can_sim.py
Version: 0.1.0
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
