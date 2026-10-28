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
    "CurrentDepartment",
    "CurrentJobTitle",
    "NewDepartment",
    "NewJobTitle",
    "ApprovalStatus"
)

foreach ($Field in $RequiredFields) {
    $Value = $Employee.$Field

    if ([string]::IsNullOrWhiteSpace([string]$Value)) {
        Write-Output "MOVE BLOCKED"
        Write-Output "Reason: Required field '$Field' is missing or empty."
        exit 4
    }
}

foreach ($Field in @("CurrentAccess", "RequestedAccess")) {
    $AccessList = $Employee.$Field

    if (
        $null -eq $AccessList -or
        $AccessList -isnot [array] -or
        $AccessList.Count -eq 0 -or
        @($AccessList | Where-Object {
            -not [string]::IsNullOrWhiteSpace([string]$_)
        }).Count -ne $AccessList.Count
    ) {
        Write-Output "MOVE BLOCKED"
        Write-Output "Reason: $Field must contain at least one non-empty access item."
        exit 5
    }
}

$AllowedAccessByRole = @{
    "HR Analyst" = @("HR-Basic")
    "Help Desk Analyst" = @("HelpDesk-Basic")
}

if (-not $AllowedAccessByRole.ContainsKey($Employee.NewJobTitle)) {
    Write-Output "MOVE BLOCKED"
    Write-Output "Reason: New job title is not defined in lab access policy."
    exit 6
}

$AllowedAccess = $AllowedAccessByRole[$Employee.NewJobTitle]

foreach ($Access in $Employee.RequestedAccess) {
    if ($Access -notin $AllowedAccess) {
        Write-Output "MOVE BLOCKED"
        Write-Output "Reason: Requested access item '$Access' is not allowed for the new role."
        exit 6
    }
}

if ($Employee.ApprovalStatus -ne "Approved") {
    Write-Output "ACCESS NOT AUTHORIZED"
    Write-Output "Reason: Approval status is '$($Employee.ApprovalStatus)'."
    exit 2
}

Write-Output "REQUIRED DATA VERIFIED"
Write-Output "ROLE ACCESS POLICY VERIFIED"
Write-Output "APPROVAL VERIFIED"
Write-Output "Move request may proceed to access reconciliation."
