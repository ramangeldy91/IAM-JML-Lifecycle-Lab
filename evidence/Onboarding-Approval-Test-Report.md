\# Test Report: Onboarding Approval Validation



\## Objective



Verify that the onboarding validation script:

\- Rejects requests without approval.

\- Accepts approved requests with complete required data.

\- Rejects requests with missing required fields.

\- Handles missing input files and invalid JSON.



\## Test Case 1 — Pending Approval



\*\*Input:\*\* `employee-joiner.json`

\*\*ApprovalStatus:\*\* `Pending`



\*\*Expected result:\*\* Access is not authorized.



\*\*Actual result:\*\*

\- Output: `ACCESS NOT AUTHORIZED`

\- Exit code: `2`



\*\*Status:\*\* PASS



\## Test Case 2 — Missing Employee File



\*\*Input:\*\* `employee-does-not-exist.json`



\*\*Expected result:\*\* The script reports that the employee file cannot be found and stops processing.



\*\*Actual result:\*\*

\- Output: `Employee file not found`

\- Exit code: `1`



\*\*Status:\*\* PASS



\## Test Case 3 — Approved Request With Complete Data



\*\*Input:\*\* Temporary synthetic test file

\*\*ApprovalStatus:\*\* `Approved`



\*\*Expected result:\*\* Required data and approval are verified.



\*\*Actual result:\*\*

\- Output: `REQUIRED DATA VERIFIED`

\- Output: `APPROVAL VERIFIED`

\- Employee: `Alex Morgan`



\*\*Status:\*\* PASS



\## Test Case 4 — Approved Request With Missing Department



\*\*Input:\*\* Temporary synthetic test file

\*\*ApprovalStatus:\*\* `Approved`

\*\*Department:\*\* Empty



\*\*Expected result:\*\* Onboarding is blocked because a required field is missing.



\*\*Actual result:\*\*

\- Output: `ONBOARDING BLOCKED`

\- Reason: Required field `Department` is missing or empty.

\- Exit code: `4`



\*\*Status:\*\* PASS



\## Limitations



Tests were executed in a local PowerShell session using synthetic employee data.



No Active Directory accounts, production identities, or real access permissions were created or changed.



The script validates input-file existence, JSON parsing, required employee fields, and approval status. It does not create accounts, assign permissions, or verify actual access.



Invalid JSON handling was tested successfully. The script reported "Employee file contains invalid JSON."

## Test Case 5 — Approved Request With Allowed Access

**Input:** Temporary synthetic test file

**ApprovalStatus:** `Approved`

**RequestedAccess:** `HelpDesk-Basic`

**Expected result:** The request passes the current data, access policy, and approval checks.

**Actual result:**

- Output: `REQUIRED DATA VERIFIED`
- Output: `APPROVAL VERIFIED`
- Employee: `Alex Morgan`
- Exit code: `0` (successful execution)

**Status:** PASS

## Test Case 6 — Empty RequestedAccess List

**Input:** Temporary synthetic test file

**RequestedAccess:** `[]`

**Expected result:** Onboarding is blocked because at least one non-empty access item is required.

**Actual result:**

- Output: `ONBOARDING BLOCKED`
- Reason: `RequestedAccess must contain at least one non-empty access item.`
- Exit code: `5`

**Status:** PASS

## Test Case 7 — Empty RequestedAccess Item

**Input:** Temporary synthetic test file

**RequestedAccess:** `[""]`

**Expected result:** Onboarding is blocked because the access list contains an empty item.

**Actual result:**

- Output: `ONBOARDING BLOCKED`
- Reason: `RequestedAccess must contain at least one non-empty access item.`
- Exit code: `5`

**Status:** PASS

## Test Case 8 — Approved Request With Disallowed Access

**Input:** Temporary synthetic test file

**ApprovalStatus:** `Approved`

**RequestedAccess:** `Domain-Admin`

**Expected result:** The request is blocked because `Domain-Admin` is not in the allowed access list.

**Actual result:**

- Output: `ONBOARDING BLOCKED`
- Reason: `Requested access item 'Domain-Admin' is not allowed by lab policy.`
- Exit code: `6`

**Status:** PASS

## Test Case 9 — Mixed Allowed and Disallowed Access

**Input:** Temporary synthetic test file

**ApprovalStatus:** `Approved`

**RequestedAccess:** `HelpDesk-Basic`, `Domain-Admin`

**Expected result:** The entire request is blocked because at least one requested access item is not allowed by lab policy.

**Actual result:**

- Output: `ONBOARDING BLOCKED`
- Reason: `Requested access item 'Domain-Admin' is not allowed by lab policy.`
- Exit code: `6`

**Status:** PASS

## Updated Limitations

The lab uses synthetic employee data and local PowerShell execution. It does not create Active Directory accounts, assign real permissions, or connect to a production identity system.

The access allowlist currently permits only `HelpDesk-Basic`. This is a simplified lab policy, not a complete organizational authorization model. The script checks requested group names against this allowlist but does not provision access or validate permissions in an actual directory.
