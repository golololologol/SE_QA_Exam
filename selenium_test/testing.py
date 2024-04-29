"""Module to test authentication flow using Selenium."""

import os
import unittest
from selenium import webdriver

class TestAuthFlow(unittest.TestCase):
    """Class to test authentication flows."""

    def setUp(self):
        """Set up the WebDriver for use in all tests."""
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(10)

    def tearDown(self):
        """Tear down the WebDriver."""
        self.driver.quit()

    def _screenshot(self, name):
        """Capture a screenshot of the current state."""
        if not os.path.exists('screenshots'):
            os.makedirs('screenshots')
        self.driver.save_screenshot(f'screenshots/{name}.png')

    def test_auth_flow_correct_credentials(self):
        """Test authentication with correct credentials."""
        base_url = "http://the-internet.herokuapp.com/digest_auth"
        self.driver.get(base_url)
        self._screenshot('start') # the screenshot will be empty because the alert is on another layer
        self.driver.get('http://admin:admin@the-internet.herokuapp.com/digest_auth')
        self._screenshot('after_auth')

    def test_auth_flow_wrong_credentials(self):
        """Test authentication with wrong credentials."""
        base_url = "http://the-internet.herokuapp.com/digest_auth"
        self.driver.get(base_url)
        self._screenshot('start_wrong') # the screenshot will be empty because the alert is on another layer
        self.driver.get('http://admin:wrong@the-internet.herokuapp.com/digest_auth')
        self._screenshot('after_auth_wrong') # the screenshot will be empty because the alert is on another layer

if __name__ == "__main__":
    unittest.main(verbosity=2)
