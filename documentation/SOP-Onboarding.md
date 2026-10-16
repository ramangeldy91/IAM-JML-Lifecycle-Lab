# SOP: Employee Onboarding

## 1. Purpose

Define a controlled process for provisioning access to a new employee.

## 2. Preconditions

Before making changes, the technician must:

- Confirm that the onboarding request came through an approved channel.
- Verify the required authorization.
- Confirm the employee's name, start date, department, and job role.
- Identify the approved access requirements for the role.
- Clarify any missing or conflicting information before proceeding.

## 3. Procedure

### Step 1 — Review the Request

Check that the request contains the required employee details,
effective date, requested access, and approvals.

If approval is missing, do not provision access. Request clarification.

### Step 2 — Create the Identity

Create the account in the designated identity system
using the organization's naming and account-management standards.

Use only approved identity attributes and test data in this lab.

### Step 3 — Assign Access

Assign only the groups, roles, and permissions approved for the employee.

Do not grant administrative privileges merely for convenience.
Follow the principle of least privilege.

### Step 4 — Apply Security Controls

Apply the authentication requirements and security settings
defined by the applicable policy, including MFA where required.

### Step 5 — Verify the Result

Verify that:

- The account exists and has the expected status.
- The assigned groups and roles match the approved request.
- No unapproved privileges were added.
- Required authentication controls are configured, where verifiable.

### Step 6 — Document and Close

Record the actions performed, verification results,
relevant approvals, and any outstanding issues.

Close the request only when the required checks are complete
or the remaining work is clearly documented and handled appropriately.

## 4. Exception Handling

If the request is incomplete, approval cannot be verified,
or the resulting access differs from the approved request,
stop the affected provisioning activity and follow the escalation process.

## 5. Lab Status

This is a proposed procedure for a simulated training lab.
Technical implementation and test evidence will be documented separately.
