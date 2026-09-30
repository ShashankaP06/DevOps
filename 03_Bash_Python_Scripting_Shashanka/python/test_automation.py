import unittest

from automation_basics import healthy_services


class HealthyServicesTests(unittest.TestCase):
    def test_only_healthy_services_are_returned(self):
        config = {
            "services": [
                {"name": "api", "healthy": True},
                {"name": "worker", "healthy": False},
            ]
        }
        self.assertEqual(healthy_services(config), ["api"])

    def test_missing_healthy_flag_is_unhealthy(self):
        self.assertEqual(healthy_services({"services": [{"name": "api"}]}), [])


if __name__ == "__main__":
    unittest.main()
