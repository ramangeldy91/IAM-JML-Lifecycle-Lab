# Test Report: Onboarding Approval Validation

## Objective

Verify that the onboarding approval validation script
rejects requests without approval and handles missing input files.

## Test Case 1 — Pending Approval

**Input:** employee-joiner.json

**ApprovalStatus:** Pending

**Expected result:** Access is not authorized.

**Actual result:**
- Output: ACCESS NOT AUTHORIZED
- Reason: Approval status is Pending
- Exit code: 2

**Status:** PASS

## Test Case 2 — Missing Employee File

**Input:** employee-does-not-exist.json

**Expected result:** The script reports that the employee file
cannot be found and stops processing.

**Actual result:**
- Output: Employee file not found
- Exit code: 1

**Status:** PASS

## Limitations

These tests were executed in a local PowerShell session using
synthetic employee data.

No Active Directory accounts, production identities,
or real access permissions were created or changed.

The script currently validates approval status and input-file
existence only. Additional validation and test cases are planned.
