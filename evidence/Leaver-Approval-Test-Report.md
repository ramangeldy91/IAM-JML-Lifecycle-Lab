# Leaver Approval Validation — Test Report

## 1. Objective

Verify that employee offboarding requests contain the required data, use a valid departure date and time format, and have the required approval before proceeding to an authorized execution process.

## 2. Test Environment

- Platform: Windows PowerShell
- Test data: Synthetic employee record (`LAB-1001`)
- Validator: `powershell/Test-LeaverApproval.ps1`
- Automated test suite: `powershell/Test-LeaverApproval.Tests.ps1`

## 3. Test Results

| Test Scenario | Expected Result | Result |
|---|---|---|
| Approved request with valid departure date | Request passes validation; exit code 0 | PASS |
| Pending approval | Request is rejected; exit code 2 | PASS |
| Invalid departure date format | Request is blocked; exit code 7 | PASS |
| Missing required field | Request is blocked; exit code 4 | PASS |

**Summary: 4 passed, 0 failed.**

## 4. Security Controls Demonstrated

- Required-field validation
- Departure date and time format validation
- Approval enforcement before offboarding proceeds
- Explicit exit codes for different validation outcomes
- Automated negative and positive testing

## 5. Limitations

This lab validates the offboarding request only. It does not disable accounts, revoke sessions or tokens, remove group memberships, recover assets, or modify permissions.

Real offboarding actions must follow approved organizational procedures. Authorized personnel must verify the resulting access state and document completion.

All employee data used in this lab is synthetic. No real Windows accounts are modified.
