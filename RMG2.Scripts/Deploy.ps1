####################################################################
##    WARNNING: Do not modify without permission
##    CANNOT move to reserved folder, due to Octopus Version 2.6.5
####################################################################


if (! $connectionString)
{
    Write-Host "Missing required variable connectionString" -ForegroundColor Yellow
    exit 1
}
if (! $dacPath)
{
    Write-Host "Missing required variable dacPath" -ForegroundColor Yellow
    exit 1
}
Write-Host ">> ConnectionString = $connectionString"
Write-Host ">> DacPath = $dacPath"

# Add the DLL
Add-Type -path $dacPath 
#DN this is alternative way of loading library, it didn't help to load DAC on RMG server, reverted
#[System.Reflection.Assembly]::LoadFrom($dacPath)

# Create the connection string
$d = New-Object Microsoft.SqlServer.Dac.DacServices $connectionString

$dacpac = (Get-Location).Path + "\RMG2.Scripts.dacpac";
Write-Host $dacpac

# Load dacpac from file & deploy to database
$dp = [Microsoft.SqlServer.Dac.DacPackage]::Load($dacpac)

# Set the DacDeployOptions
$options = New-Object Microsoft.SqlServer.Dac.DacDeployOptions -Property @{
 'BlockOnPossibleDataLoss' = $false;
 'DropObjectsNotInSource' = $false;
 'ScriptDatabaseOptions' = $false;
 'IgnorePermissions' = $true;
 'IgnoreRoleMembership' = $true
}

# Set params
$outputFileName = "RMG_MAIN"

# Generate the deplopyment script
$deployScriptName = $outputFileName + ".sql"
$deployScript = $d.GenerateDeployScript($dp, $outputFileName, $options)

# Return the script to the log
Write-Host "Loading $deployScript"

# Write the script out to a file
$deployScript | Out-File $deployScriptName

# Deploy the dacpac
$d.Deploy($dp, $outputFileName, $true, $options)