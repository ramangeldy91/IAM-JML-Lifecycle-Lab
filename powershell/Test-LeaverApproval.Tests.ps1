$ErrorActionPreference = "Stop"

$Validator = Join-Path $PSScriptRoot "Test-LeaverApproval.ps1"
$TestEmployeeFile = Join-Path (Split-Path $PSScriptRoot -Parent) "employee-leaver-test.json"
$Passed = 0
$Failed = 0

function Invoke-LeaverTest {
    param(
        [string]$Name,
        [object]$Employee,
        [int]$ExpectedExitCode,
        [string]$ExpectedOutput
    )

    $Employee | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $TestEmployeeFile -Encoding utf8

    $Output = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Validator -EmployeeFile $TestEmployeeFile 2>&1
    $ActualExitCode = $LASTEXITCODE
    $OutputText = $Output -join "`n"

    if ($ActualExitCode -eq $ExpectedExitCode -and $OutputText -match [regex]::Escape($ExpectedOutput)) {
        Write-Output "PASS: $Name"
        $script:Passed++
    }
    else {
        Write-Output "FAIL: $Name"
        Write-Output "Expected exit code: $ExpectedExitCode"
        Write-Output "Actual exit code: $ActualExitCode"
        Write-Output "Output: $OutputText"
        $script:Failed++
    }
}

try {
    $ApprovedEmployee = [ordered]@{
        EmployeeID = "LAB-1001"
        FirstName = "Alex"
        LastName = "Morgan"
        Department = "Human Resources"
        JobTitle = "HR Analyst"
        DepartureDateTime = "2026-11-15T17:00:00"
        ApprovalStatus = "Approved"
    }

    Invoke-LeaverTest -Name "Approved request with valid departure date" -Employee $ApprovedEmployee -ExpectedExitCode 0 -ExpectedOutput "APPROVAL VERIFIED"

    $PendingEmployee = [ordered]@{}; foreach ($key in $ApprovedEmployee.Keys) { $PendingEmployee[$key] = $ApprovedEmployee[$key] }
    $PendingEmployee.ApprovalStatus = "Pending"
    Invoke-LeaverTest -Name "Pending approval rejected" -Employee $PendingEmployee -ExpectedExitCode 2 -ExpectedOutput "OFFBOARDING NOT AUTHORIZED"

    $InvalidDateEmployee = [ordered]@{}; foreach ($key in $ApprovedEmployee.Keys) { $InvalidDateEmployee[$key] = $ApprovedEmployee[$key] }
    $InvalidDateEmployee.DepartureDateTime = "15-11-2026"
    Invoke-LeaverTest -Name "Invalid departure date rejected" -Employee $InvalidDateEmployee -ExpectedExitCode 7 -ExpectedOutput "OFFBOARDING BLOCKED"

    $MissingFieldEmployee = [ordered]@{}; foreach ($key in $ApprovedEmployee.Keys) { $MissingFieldEmployee[$key] = $ApprovedEmployee[$key] }
    $MissingFieldEmployee.Remove("Department")
    Invoke-LeaverTest -Name "Missing required field rejected" -Employee $MissingFieldEmployee -ExpectedExitCode 4 -ExpectedOutput "Required field 'Department' is missing or empty."
}
finally {
    if (Test-Path -LiteralPath $TestEmployeeFile) {
        Remove-Item -LiteralPath $TestEmployeeFile -Force
    }
}

Write-Output ""
Write-Output "Test summary: $Passed passed; $Failed failed."

if ($Failed -gt 0) {
    exit 1
}

exit 0

