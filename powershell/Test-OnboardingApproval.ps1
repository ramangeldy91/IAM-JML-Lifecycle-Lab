param(
    [Parameter(Mandatory = $true)]
    [string]$EmployeeFile
)

if (-not (Test-Path -LiteralPath $EmployeeFile -PathType Leaf)) {
    Write-Error "Employee file not found: $EmployeeFile"
    exit 1
}

try {
    $Employee = Get-Content -LiteralPath $EmployeeFile -Raw |
        ConvertFrom-Json -ErrorAction Stop
}
catch {
    Write-Error "Employee file contains invalid JSON."
    exit 3
}

$RequiredFields = @(
    "EmployeeID",
    "FirstName",
    "LastName",
    "Department",
    "JobTitle",
    "EmploymentStatus",
    "ApprovalStatus"
)

foreach ($Field in $RequiredFields) {
    $Value = $Employee.$Field

    if ([string]::IsNullOrWhiteSpace([string]$Value)) {
        Write-Output "ONBOARDING BLOCKED"
        Write-Output "Reason: Required field '$Field' is missing or empty."
        exit 4
    }
}
if (
    $null -eq $Employee.RequestedAccess -or
    $Employee.RequestedAccess -isnot [array] -or
    $Employee.RequestedAccess.Count -eq 0 -or
    @($Employee.RequestedAccess | Where-Object {
        -not [string]::IsNullOrWhiteSpace([string]$_)
    }).Count -ne $Employee.RequestedAccess.Count
) {
    Write-Output "ONBOARDING BLOCKED"
    Write-Output "Reason: RequestedAccess must contain at least one non-empty access item."
    exit 5
}

$AllowedAccess = @(
    "HelpDesk-Basic"
)

foreach ($Access in $Employee.RequestedAccess) {
    if ($Access -notin $AllowedAccess) {
        Write-Output "ONBOARDING BLOCKED"
        Write-Output "Reason: Requested access item '$Access' is not allowed by lab policy."
        exit 6
    }
}
if ($Employee.ApprovalStatus -ne "Approved") {
    Write-Output "ACCESS NOT AUTHORIZED"
    Write-Output "Reason: Approval status is '$($Employee.ApprovalStatus)'."
    exit 2
}

Write-Output "REQUIRED DATA VERIFIED"
Write-Output "APPROVAL VERIFIED"
Write-Output "Employee: $($Employee.FirstName) $($Employee.LastName)"
Write-Output "Requested access may proceed to the next validation step."