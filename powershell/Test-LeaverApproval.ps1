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
    "DepartureDateTime",
    "ApprovalStatus"
)

foreach ($Field in $RequiredFields) {
    $Value = $Employee.$Field

    if ([string]::IsNullOrWhiteSpace([string]$Value)) {
        Write-Output "OFFBOARDING BLOCKED"
        Write-Output "Reason: Required field '$Field' is missing or empty."
        exit 4
    }
}

$DepartureDate = [datetime]::MinValue
$DateIsValid = [datetime]::TryParseExact(
    [string]$Employee.DepartureDateTime,
    "yyyy-MM-ddTHH:mm:ss",
    [System.Globalization.CultureInfo]::InvariantCulture,
    [System.Globalization.DateTimeStyles]::None,
    [ref]$DepartureDate
)

if (-not $DateIsValid) {
    Write-Output "OFFBOARDING BLOCKED"
    Write-Output "Reason: DepartureDateTime must use yyyy-MM-ddTHH:mm:ss format."
    exit 7
}

if ($Employee.ApprovalStatus -ne "Approved") {
    Write-Output "OFFBOARDING NOT AUTHORIZED"
    Write-Output "Reason: Approval status is '$($Employee.ApprovalStatus)'."
    exit 2
}

Write-Output "REQUIRED DATA VERIFIED"
Write-Output "DEPARTURE DATE VERIFIED"
Write-Output "APPROVAL VERIFIED"
Write-Output "Offboarding request may proceed to the authorized execution process."
