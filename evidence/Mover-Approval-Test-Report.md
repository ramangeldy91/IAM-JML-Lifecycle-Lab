# Mover Approval Validation - Test Report

## 1. Objective

Verify that employee role-change requests contain the required data, that current access is consistent with the employee's current role, that requested access is permitted for the new role, and that approval is required before access reconciliation proceeds.

## 2. Test Environment

- Platform: Windows PowerShell
- Test data: Synthetic employee record (`LAB-TEST-MOVER-001`)
- Validator: `powershell/Test-MoverApproval.ps1`
- Automated test suite: `powershell/Test-MoverApproval.Tests.ps1`

## 3. Test Results

| Test Scenario | Expected Result | Result |
|---|---|---|
| Approved request with role-allowed access | Request passes validation; exit code 0 | PASS |
| Pending approval | Request is rejected; exit code 2 | PASS |
| Disallowed requested access | Request is blocked; exit code 6 | PASS |
| Disallowed current access | Request is blocked; exit code 6 | PASS |

**Summary: 4 passed, 0 failed.**

## 4. Security Controls Demonstrated

- Required-field validation
- Current and requested access-list validation
- Current-role and new-role access-policy validation
- Detection of access inconsistent with the employee's current role
- Least-privilege enforcement for requested access
- Approval enforcement before access reconciliation
- Explicit exit codes for validation outcomes
- Automated positive and negative testing

## 5. Limitations

This lab validates the mover request only. It does not modify employee attributes in a production directory, grant or remove permissions, change group memberships, or execute access reconciliation.

Real role changes must follow approved organizational procedures. Authorized personnel must verify the resulting access state and document completion.

All employee data used in this lab is synthetic. No real Windows accounts are modified.
