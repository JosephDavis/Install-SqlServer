function Install-SqlServer {
  [CmdletBinding()]
  param (
    # The path to the SQL Server installation image
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $ImagePath,

    # The extraction location for the installation media, used as the SourcePath for the DSC configuration
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $SourcePath
  )

  begin {
    New-Item -Path $SourcePath -ItemType Directory -force
    Copy-Item -Path (Join-Path -Path (Get-PSDrive -Name ((Mount-DiskImage -ImagePath $ImagePath -PassThru) | Get-Volume).DriveLetter).Root -ChildPath '*') -Destination $SourcePath -Recurse -force
    Dismount-DiskImage -ImagePath $ImagePath

    # Ensure NuGet package provider is present
    Get-PackageProvider -Name NuGet -ForceBootstrap

    # Ensure SqlServerDsc module is present
    if (!(Get-Module SqlServerDsc)) {
      Install-Module -Name SqlServerDsc -Force
    }
  }

  process {
    # Compile configuration
    & .\SqlServerConfiguration.ps1 -SourcePath $SourcePath

    # Run DSC configuration
    Start-DscConfiguration -Path C:\SqlServerConfiguration -Wait -Force -Verbose
  }

  end {
    if (Test-DscConfiguration) {
      Write-Host 'Removing configuration directory...'
      Remove-Item .\SqlServerConfiguration -Recurse -force

      Write-Host 'Removing extract directory...'
      Remove-Item $SourcePath -Recurse -force

      Write-Host 'Done.'
    }
  }
}
