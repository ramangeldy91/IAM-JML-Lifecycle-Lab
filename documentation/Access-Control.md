# Access Control and Least Privilege

## 1. Purpose

Define how access should be requested, approved, assigned,
reviewed, and removed in the simulated IAM environment.

## 2. Core Principles

### Least Privilege

Users should receive only the access required for their
approved job responsibilities.

### Authorization

Access changes must be supported by an approved request
or another explicitly authorized process.

### Separation of Duties

Where applicable, sensitive actions should require
appropriate separation between requester, approver, and implementer.

### Accountability

Access changes must be traceable through appropriate
records, approvals, and verification evidence.

## 3. Access Request Workflow

1. Receive the request through an approved channel.
2. Identify the user, requested resource, and business purpose.
3. Verify the requester's authority and required approval.
4. Confirm the requested access is appropriate for the role.
5. Assign the minimum approved permissions.
6. Verify the resulting access.
7. Document the action and close the request.

If approval is missing or the request is unclear,
do not grant the requested access until the issue is resolved.

## 4. Role Changes

When an employee changes roles:

- Review the employee's current entitlements.
- Identify permissions required for the new role.
- Obtain approval for new or exceptional access.
- Remove obsolete access according to policy.
- Verify that retained access remains justified.
- Document the changes and their verification.

Do not remove every existing group automatically:
some access may be shared or still required and authorized.

## 5. Privileged Access

Administrative privileges require additional scrutiny.

Before granting privileged access:

- Verify the request and business justification.
- Confirm approval from the appropriate authority.
- Prefer limited, task-specific permissions.
- Use time-bound or just-in-time access where supported.
- Ensure appropriate logging and post-change verification.

Never grant privileged access solely because a user asks for it.

## 6. Access Reviews

Access should be reviewed according to organizational policy
and when relevant events occur, including role changes.

Investigate unexpected, excessive, or unjustified permissions.
Record review findings and remediation actions.

## 7. Verification Evidence

Suitable evidence may include:

- Approved request or ticket reference.
- Before-and-after group or role membership.
- Relevant account status.
- Verification results.
- Date, action, and responsible technician.
- Exceptions and escalation records.

Evidence must use synthetic lab data and exclude secrets
or confidential information.

## 8. Lab Limitations

This document describes the intended control process.
Platform-specific implementation and test results will be added
as the lab develops.
