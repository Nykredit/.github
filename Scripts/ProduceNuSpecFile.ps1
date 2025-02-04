param(
    [string] $Version,
    [string] $PackageId,
    [string] $MainProjectFolder,
    [string] $PublishFolder
)
$directCopyFolder = "./$MainProjectFolder/$PublishFolder"
$directCopyFiles = Get-ChildItem -Path $directCopyFolder -File 

$filesSection = [System.Text.StringBuilder]::new()
$filesSection.AppendLine('<files>')
foreach($fil in $directCopyFiles) 
{ 
    $filesSection.AppendLine('  <file src="./' + $PublishFolder + '/' + $fil.Name + '" target="content"/>')   
}

$wwwFolder = $directCopyFolder + '/wwwroot'
Write-Host $wwwFolder

if(Test-Path $wwwFolder) 
{
    $wwwFiles = Get-ChildItem -Path $wwwFolder -File -Recurse
    foreach($fil in $wwwFiles) 
    {
       $relativeFile = Resolve-Path -Path $fil.FullName -RelativeBasePath $wwwFolder -Relative
       $filesSection.AppendLine('  <file src="./' + $PublishFolder + '/wwwroot/' + $relativeFile + '" target="content/wwwroot/' + $relativeFile + '"/>')   
    }
}


$filesSection.AppendLine('</files>')

$filesSectionString = $filesSection.ToString()

$nuSpecData = @"
<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
<metadata>
    <id>$PackageId</id>
    <version>$Version</version>
    <authors>Nykredit DCI</authors>
    <licenseUrl>https://www.nykredit.dk/</licenseUrl>
    <projectUrl>https://www.nykredit.dk/</projectUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>$PackageId $Version</description>
</metadata>
$filesSectionString
</package>
"@


$nuspecFilePath = "./$MainProjectFolder/Package.nuspec"
Write-Host "Writing nuspec file to: $nuspecFilePath with content: $nuSpecData"

$nuSpecData.ToString() > $nuspecFilePath
