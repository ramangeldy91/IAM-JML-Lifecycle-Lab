# Joiner-Mover-Leaver (JML) Workflow

## 1. Purpose

This workflow defines how employee identities and access rights
should be managed throughout the employee lifecycle.

## 2. Joiner — New Employee

### Trigger
An authorized onboarding request is received.

### Procedure
1. Verify the request and required approvals.
2. Confirm the employee's identity attributes and job role.
3. Create the account in the approved identity system.
4. Assign only the groups and permissions required for the role.
5. Apply required authentication and security controls.
6. Verify that the employee can access authorized resources.
7. Record actions, verification results, and relevant approvals.

### Security Risks
- Unauthorized account creation.
- Excessive permissions.
- Missing authentication controls.

## 3. Mover — Employee Changes Role

### Trigger
An approved request changes an employee's department or job role.

### Procedure
1. Verify the approved role-change request.
2. Identify current access and the access required for the new role.
3. Obtain approval for any new access where required.
4. Remove obsolete permissions according to policy.
5. Assign approved permissions for the new role.
6. Verify the resulting access.
7. Document changes and any justified retained access.

### Security Risks
- Accumulation of unnecessary permissions.
- Inappropriate access to former department resources.
- Unauthorized privilege escalation.

## 4. Leaver — Employee Departure

### Trigger
An authorized notification confirms the employee's departure.

### Procedure
1. Verify the departure request and effective time.
2. Disable or block sign-in at the approved time.
3. Revoke active sessions or tokens where supported and required.
4. Remove or disable access to relevant systems according to policy.
5. Coordinate device recovery and asset tracking.
6. Preserve required records and evidence according to policy.
7. Verify the account's final state and document the actions.

### Security Risks
- Former employees retaining access.
- Active sessions remaining usable.
- Incomplete asset recovery or audit records.

## 5. Core Security Principles

- Least privilege.
- Formal authorization.
- Separation of duties where applicable.
- Verification after changes.
- Traceable documentation.
- Compliance with organizational policy.

## 6. Lab Limitations

This document describes a proposed workflow for a simulated lab.
Actual technical implementations and verification evidence will be added
as the lab develops. Production procedures must follow the organization's
approved policies and identity platform capabilities.

## 7. Mover Lab Implementation

### Objective

Validate a simulated employee role-change request before proceeding to access reconciliation.

### Test Scenario

A synthetic employee changes from:

- **Current department:** IT Support

- **Current job title:** Help Desk Analyst

- **Current access:** `HelpDesk-Basic`

To:

- **New department:** Human Resources

- **New job title:** HR Analyst

- **Requested access:** `HR-Basic`

The request must have an `Approved` status before it can proceed.

### Validation Controls

The PowerShell validator checks:

1. The employee JSON file exists and contains valid JSON.

2. Required employee and role-change fields are present.

3. Current and requested access lists contain valid, non-empty items.

4. The new job title is defined in the lab's role-access policy.

5. Requested access is permitted for the new role.

6. The request has the required approval status.

### Automated Test Results

The automated test suite verifies three scenarios:

- An approved request with role-allowed access is accepted.

- A request with pending approval is rejected.

- A request for disallowed access, such as `Domain-Admin` for an HR Analyst, is rejected.

**Latest test result:** 3 passed, 0 failed.

### Implementation Limitations

The current validator checks request data, approval status, and role-based access eligibility. It does not create or modify accounts, assign or revoke permissions, or automatically reconcile current access with the new role's requirements.

Before any access changes in a real environment, the responsible administrator must follow the organization's approved procedures, verify authorization, assess which existing permissions remain necessary, and confirm the resulting access.

This lab uses synthetic employee data and does not modify real Windows accounts.

## 8. Leaver Lab Implementation

### Objective

Validate employee offboarding requests before they proceed to an authorized execution process. The lab checks required employee data, departure date and time format, and approval status.

### Synthetic Scenario

Employee: Alex Morgan
Employee ID: LAB-1001
Department: Human Resources
Job Title: HR Analyst
Departure Date and Time: 2026-11-15T17:00:00
Initial Approval Status: Pending

The employee record uses synthetic data. The initial request remains pending and must not proceed until the required approval is confirmed.

### Validation Controls

The PowerShell validator (`powershell/Test-LeaverApproval.ps1`) checks:

1. The employee data file exists.
2. The JSON document is valid.
3. Required fields are present and non-empty.
4. `DepartureDateTime` matches the required `yyyy-MM-ddTHH:mm:ss` format and can be parsed.
5. `ApprovalStatus` is `Approved`.

The validator returns distinct exit codes for missing files, invalid JSON, missing required fields, pending approval, and invalid departure date formats.

### Automated Test Results

The automated test suite (`powershell/Test-LeaverApproval.Tests.ps1`) verifies four scenarios:

- An approved request with a valid departure date is accepted.
- A request with pending approval is rejected.
- An invalid departure date format is rejected.
- A request missing a required field is rejected.

**Latest test result:** 4 passed, 0 failed.

### Implementation Limitations

This validator checks request data, departure date format, and approval status. It does not disable accounts, revoke sessions or tokens, remove group memberships, recover assets, or change permissions.

In a real environment, offboarding actions must be performed by authorized personnel in accordance with approved organizational procedures and the effective departure time. The resulting access state must then be verified and documented.

This lab uses synthetic employee data and does not modify real Windows accounts.
