"""
License: MIT
Author: Thomas Fischer
File: test_can_manager.py
Version: 0.1.1
Description: Unit tests for CANManager class
"""

import unittest
from unittest.mock import MagicMock, patch
from src.tfitpican_simulator.can_manager import CANManager
from src.tfitpican_simulator.can_sim import CANBusSimulator

class TestCANManager(unittest.TestCase):

    def setUp(self):
        # Mock the simulator so we don't rely on its real implementation
        self.mock_simulator = MagicMock(spec=CANBusSimulator)
        self.can_manager = CANManager(self.mock_simulator)

    def test_init(self):
        # Ensure the manager stores the simulator correctly
        self.assertIsNotNone(self.can_manager.simulator,
                             "CANManager should reference a simulator")

    def test_connect_can(self):
        # Verify 'connect_can' outputs the expected message
        with patch('builtins.print') as mock_print:
            self.can_manager.connect_can()
            mock_print.assert_called_once_with("CAN interface connected")

    def test_disconnect_can(self):
        # Verify 'disconnect_can' outputs the expected message
        with patch('builtins.print') as mock_print:
            self.can_manager.disconnect_can()
            mock_print.assert_called_once_with("CAN interface disconnected")

    def test_handle_message(self):
        # Verify 'handle_message' prints the correct message
        test_msg = "test CAN message"
        with patch('builtins.print') as mock_print:
            self.can_manager.handle_message(test_msg)
            mock_print.assert_called_once_with(f"Handling message: {test_msg}")

    def test_handle_message_sim_integration(self):
        # If in the future the manager should pass the message to the simulator,
        # you can test that here. For now, we just confirm no crash occurs.
        test_msg = "another CAN message"
        self.can_manager.handle_message(test_msg)
        # Potentially verify the simulator was called if that becomes a requirement:
        # self.mock_simulator.some_method.assert_called_with(test_msg)

if __name__ == "__main__":
    unittest.main()
