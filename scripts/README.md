Scripts to validate and fix Rust test functions according to project rules.

Usage:
- Validate only: python3 scripts/validate_tests.py --repo .
- Dry-run fixes: python3 scripts/fix_tests.py --repo . --dry-run
- Apply fixes: python3 scripts/fix_tests.py --repo . --apply --backup-dir scripts/backups

Notes:
- These scripts are conservative and operate on simple AST-like heuristics. They should be reviewed before applying to many files.
- Backups are stored in the provided --backup-dir when --apply is used.
