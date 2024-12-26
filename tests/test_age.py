import unittest

from helper.year_operation import categorize_by_age

class TestCategorizeByAge(unittest.TestCase):
	def setUp(self):
		print("\nStarting a new test case...")
	def tearDown(self):
		print("Test case finished \n")
	def test_child(self):
		self.assertEqual(categorize_by_age(5), "Child")
	def test_adolescent(self):
		self.assertEqual(categorize_by_age(15), "Adolescent")
	def test_adult(self):
		self.assertEqual(categorize_by_age(30), "Adult")
	def test_golden_age(self):
		self.assertEqual(categorize_by_age(70), "Golden age")
	def test_negative_age(self):
		self.assertEqual(categorize_by_age(-1), "Invalid age: -1")
	def test_too_old(self):
		self.assertEqual(categorize_by_age(155), "Invalid age: 155")

if __name__ == "__main__":
    unittest.main(verbosity=2)
