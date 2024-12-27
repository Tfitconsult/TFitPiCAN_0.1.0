\"\"\"
License: MIT
Author: Thomas Fischer
File: test_can_sim.py
Version: 0.1.0
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
