$ErrorActionPreference = "Stop"

$ValidatorPath = Join-Path $PSScriptRoot "Test-MoverApproval.ps1"
$ProjectRoot = Split-Path $PSScriptRoot -Parent
$TestDataPath = Join-Path $ProjectRoot "employee-mover-test.json"

$Passed = 0
$Failed = 0

if (-not (Test-Path -LiteralPath $ValidatorPath -PathType Leaf)) {
    throw "Mover validator not found: $ValidatorPath"
}

$Employee = [ordered]@{
    EmployeeID       = "LAB-TEST-MOVER-001"
    FirstName        = "Test"
    LastName         = "Employee"
    CurrentDepartment = "IT Support"
    CurrentJobTitle   = "Help Desk Analyst"
    CurrentAccess     = @("HelpDesk-Basic")
    NewDepartment     = "Human Resources"
    NewJobTitle       = "HR Analyst"
    RequestedAccess  = @("HR-Basic")
    ApprovalStatus   = "Approved"
}

function Invoke-MoverTest {
    param(
        [string]$Name,
        [int]$ExpectedExitCode,
        [string]$ExpectedOutput
    )

    $Output = @(
        & powershell.exe -NoProfile -ExecutionPolicy Bypass `
            -File $ValidatorPath `
            -EmployeeFile $TestDataPath 2>&1 |
            ForEach-Object { "$_" }
    )

    $ActualExitCode = $LASTEXITCODE
    $CombinedOutput = $Output -join "`n"

    if (
        $ActualExitCode -eq $ExpectedExitCode -and
        $CombinedOutput -match [regex]::Escape($ExpectedOutput)
    ) {
        Write-Host "PASS: $Name"
        $script:Passed++
    }
    else {
        Write-Host "FAIL: $Name"
        Write-Host "  Expected exit code: $ExpectedExitCode"
        Write-Host "  Actual exit code:   $ActualExitCode"
        Write-Host "  Output:"
        Write-Host $CombinedOutput
        $script:Failed++
    }
}

try {
    $Employee | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $TestDataPath -Encoding utf8

    Invoke-MoverTest `
        -Name "Approved request with role-allowed access" `
        -ExpectedExitCode 0 `
        -ExpectedOutput "ROLE ACCESS POLICY VERIFIED"

    $Employee.ApprovalStatus = "Pending"

    $Employee | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $TestDataPath -Encoding utf8

    Invoke-MoverTest `
        -Name "Pending approval is rejected" `
        -ExpectedExitCode 2 `
        -ExpectedOutput "ACCESS NOT AUTHORIZED"

    $Employee.ApprovalStatus = "Approved"
    $Employee.RequestedAccess = @("Domain-Admin")

    $Employee | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $TestDataPath -Encoding utf8

    Invoke-MoverTest `
        -Name "Disallowed access is rejected" `
        -ExpectedExitCode 6 `
        -ExpectedOutput "MOVE BLOCKED"

    $Employee.CurrentAccess = @("Domain-Admin")
    $Employee.RequestedAccess = @("HR-Basic")
    $Employee.ApprovalStatus = "Approved"

    $Employee | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $TestDataPath -Encoding utf8

    Invoke-MoverTest `
        -Name "Disallowed current access is rejected" `
        -ExpectedExitCode 6 `
        -ExpectedOutput "Current access item 'Domain-Admin' is not allowed"
}
finally {
    if (Test-Path -LiteralPath $TestDataPath) {
        Remove-Item -LiteralPath $TestDataPath -Force
    }
}

Write-Host ""
Write-Host "Test summary: $Passed passed; $Failed failed."

if ($Failed -gt 0) {
    exit 1
}

exit 0
