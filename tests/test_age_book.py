import unittest

from helper.year_operation import check_age_book

class TestCategorizeByAge(unittest.TestCase):
	def setUp(self):
		print("\nStarting a new test case...")
	def tearDown(self):
		print("Test case finished \n")
	def test_new(self):
		self.assertEqual(check_age_book(5), "New")
	def test_not_child(self):
		self.assertNotIn(check_age_book(5), ["Mid Year", "Old", "Anceint", "Invalid age: 5"])
	def test_mid_year(self):
		self.assertEqual(check_age_book(15), "Mid Year")
	def test_old(self):
		self.assertEqual(check_age_book(50), "Old")
	def test_anceint(self):
		self.assertEqual(check_age_book(200), "Anceint")
	def test_invalid_age(self):
		self.assertEqual(check_age_book(-1), "Invalid age: -1")

if __name__ == "__main__":
    unittest.main(verbosity=2)
