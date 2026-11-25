import unittest
from reaper import audit, normalize

class ReaperTests(unittest.TestCase):
    def test_missing(self):
        self.assertEqual(audit('https://www.facebook.com/share/example/', {})['status'], 'retrieval_required')
    def test_evidence(self):
        r = audit('https://www.facebook.com/example', {'caption':'Example'})
        self.assertEqual(r['status'], 'evidence_ready')
        self.assertIn('engagement', r['missing'])
    def test_invalid(self):
        for url in ['http://facebook.com/a','https://facebook.com.evil.example/a','https://user@facebook.com/a']:
            with self.assertRaises(ValueError):
                normalize(url)
    def test_stable(self):
        self.assertEqual(audit('https://fb.watch/example/', {})['id'], audit('https://fb.watch/example/', {})['id'])

if __name__ == '__main__':
    unittest.main()
