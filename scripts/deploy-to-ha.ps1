<#
.SYNOPSIS
    Packages the local meross_cloud integration and deploys it to a remote
    Home Assistant instance (e.g. a Raspberry Pi) for local testing.

.DESCRIPTION
    Copies the custom_components/meross_cloud directory from the current
    working copy to the target's custom_components directory via scp, and
    optionally restarts Home Assistant core via SSH.

.PARAMETER HaHost
    Hostname or IP address of the Home Assistant host (e.g. raspberrypi, 192.168.1.50).

.PARAMETER HaUser
    SSH user on the target host. Defaults to "pi".

.PARAMETER ConfigPath
    Absolute path to the Home Assistant config directory on the target host.
    Defaults to "/config" (Home Assistant OS / Supervised default).

.PARAMETER Restart
    If set, restarts Home Assistant core after deployment via "ha core restart".
    Requires the Home Assistant CLI (ha) to be available on the target (HAOS/Supervised).

.PARAMETER ShowLogs
    If set, tails the Home Assistant log for "meross" entries after restart.

.EXAMPLE
    .\deploy-to-ha.ps1 -HaHost raspberrypi -Restart -ShowLogs

.EXAMPLE
    .\deploy-to-ha.ps1 -HaHost 192.168.1.50 -HaUser homeassistant -ConfigPath /home/homeassistant/.homeassistant
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$HaHost,

    [string]$HaUser = "pi",

    [string]$ConfigPath = "/config",

    [switch]$Restart,

    [switch]$ShowLogs
)

$ErrorActionPreference = "Stop"

# Resolve repo root relative to this script's location (scripts/..)
$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot "custom_components\meross_cloud"

if (-not (Test-Path $sourceDir)) {
    throw "Could not find $sourceDir. Run this script from within the repository."
}

$remoteTarget = "${HaUser}@${HaHost}:${ConfigPath}/custom_components/meross_cloud/"

Write-Host "==> Deploying local meross_cloud integration to $HaUser@$HaHost ($ConfigPath)" -ForegroundColor Cyan

# 1. Ensure the target directory exists on the remote host
Write-Host "==> Ensuring remote directory exists" -ForegroundColor Cyan
ssh "${HaUser}@${HaHost}" "mkdir -p '${ConfigPath}/custom_components/meross_cloud'"
if ($LASTEXITCODE -ne 0) { throw "Failed to create remote directory (exit code $LASTEXITCODE)" }

# 2. Copy the current working copy to the remote host via scp
Write-Host "==> Copying files via scp" -ForegroundColor Cyan
scp -r "$sourceDir\*" $remoteTarget
if ($LASTEXITCODE -ne 0) { throw "scp failed (exit code $LASTEXITCODE)" }

Write-Host "==> Deployment complete." -ForegroundColor Green

if ($Restart) {
    Write-Host "==> Restarting Home Assistant core" -ForegroundColor Cyan
    ssh "${HaUser}@${HaHost}" "ha core restart"
    if ($LASTEXITCODE -ne 0) { throw "Restart command failed (exit code $LASTEXITCODE)" }
    Write-Host "==> Restart triggered. Waiting a moment before checking logs..." -ForegroundColor Cyan
    Start-Sleep -Seconds 20
}

if ($ShowLogs) {
    Write-Host "==> Recent 'meross' log lines" -ForegroundColor Cyan
    ssh "${HaUser}@${HaHost}" "ha core logs 2>/dev/null | grep -i meross | tail -n 50"
}

Write-Host "==> Done." -ForegroundColor Green
