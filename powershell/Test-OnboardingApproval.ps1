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

if ($Employee.ApprovalStatus -ne "Approved") {
    Write-Output "ACCESS NOT AUTHORIZED"
    Write-Output "Reason: Approval status is '$($Employee.ApprovalStatus)'."
    exit 2
}

Write-Output "REQUIRED DATA VERIFIED"
Write-Output "APPROVAL VERIFIED"
Write-Output "Employee: $($Employee.FirstName) $($Employee.LastName)"
Write-Output "Requested access may proceed to the next validation step."