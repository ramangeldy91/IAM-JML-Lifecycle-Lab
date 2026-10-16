param(
    [Parameter(Mandatory = $true)]
    [string]$EmployeeFile
)

if (-not (Test-Path -LiteralPath $EmployeeFile)) {
    Write-Error "Employee file not found: $EmployeeFile"
    exit 1
}

$Employee = Get-Content -LiteralPath $EmployeeFile -Raw |
    ConvertFrom-Json

if ($Employee.ApprovalStatus -ne "Approved") {
    Write-Output "ACCESS NOT AUTHORIZED"
    Write-Output "Reason: Approval status is '$($Employee.ApprovalStatus)'."
    exit 2
}

Write-Output "APPROVAL VERIFIED"
Write-Output "Employee: $($Employee.FirstName) $($Employee.LastName)"
Write-Output "Requested access may proceed to the next validation step."
