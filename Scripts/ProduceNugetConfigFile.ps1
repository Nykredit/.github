param(
    [string] $NexusUser,
    [string] $NexusPassword
)
$nugetConfigData = @"
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <packageSources>
    <add key="NykNexus" value="https://maven.tools.nykredit.it/nexus/repository/itcm_nuget_group/" disableTLSCertificateValidation="true" />
    <add key="NykNexusPush" value="https://maven.tools.nykredit.it/nexus/repository/itcm_solutions_releases/" disableTLSCertificateValidation="true" />
    </packageSources>
    <packageRestore>
    <add key="enabled" value="True" />
    <add key="automatic" value="True" />
    </packageRestore>
    <bindingRedirects>
    <add key="skip" value="False" />
    </bindingRedirects>
    <packageManagement>
    <add key="format" value="0" />
    <add key="disabled" value="False" />
    </packageManagement>
    <packageSourceCredentials>
        <NykNexus>
            <add key="Username" value="$NexusUser" />
            <add key="ClearTextPassword" value="$NexusPassword" />
        </NykNexus>
        <NykNexusPush>
            <add key="Username" value="$NexusUser" />
            <add key="ClearTextPassword" value="$NexusPassword" />
        </NykNexusPush>
    </packageSourceCredentials>              
</configuration>
"@
Write-Host "Using NuGet config file with content: $nugetConfigData"
$nugetConfigData.ToString() > ./nuget.config
