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
