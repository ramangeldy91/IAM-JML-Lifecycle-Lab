# IAM JML Lifecycle Lab

## Project Overview

This project simulates Identity and Access Management (IAM) processes across the employee identity lifecycle: Joiner, Mover, and Leaver (JML).

## Objectives

- Practice employee onboarding, role changes, and offboarding.
- Apply the principle of least privilege.
- Validate approvals before access-related requests proceed.
- Develop PowerShell scripting and automated testing skills.
- Document IAM workflows, security controls, and test evidence.
- Build a portfolio project for Help Desk and Junior IAM roles.

## Implemented Workflows

### Joiner — Onboarding
- Validates required employee data.
- Checks requested access against an approved allowlist.
- Rejects requests without the required approval.
- Includes automated validation tests.

### Mover — Role Change
- Validates employee and access request data.
- Checks current and requested access.
- Validates role mapping and approval status.
- Includes automated validation tests.

### Leaver — Offboarding
- Validates employee data and departure date.
- Rejects requests without the required approval.
- Includes automated validation tests.

## Automated Test Results

- Joiner: 3 tests passed.
- Mover: 3 tests passed.
- Leaver: 4 tests passed.
- Total: 10 tests passed, 0 failed.

## Security Principles

- Least privilege.
- Approval before access-related actions.
- Input validation.
- Verification and documentation.
- Safe testing with synthetic data.

## Scope and Limitations

This is a controlled lab using synthetic employee data. The scripts validate requests and approvals; they do not create, modify, or disable real user accounts, change permissions, revoke sessions, or execute production access changes.

## Project Status

Status: In progress.
