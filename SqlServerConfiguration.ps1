Configuration SqlServerConfiguration
{
  [CmdletBinding()]
  param (
    # The source path to use, usually the path the installation media was extracted to
    [Parameter(Mandatory = $true)]
    [ValidateNotNullorEmpty()]
    [String]
    $SourcePath
  )

  Import-DscResource -ModuleName PSDesiredStateConfiguration
  Import-DscResource -ModuleName SqlServerDsc

  node localhost
  {
    #region Prerequisites
    WindowsFeature 'NetFramework45' {
      Name   = 'NET-Framework-45-Core'
      Ensure = 'Present'
    }
    #endregion Prerequisites

    # Documentation for SqlSetup is available here https://github.com/PowerShell/SqlServerDsc#sqlsetup
    # Examples https://github.com/PowerShell/SqlServerDsc/tree/dev/Examples/Resources/SqlSetup
    SqlSetup 'InstallDefaultInstance' {
      DependsOn           = '[WindowsFeature]NetFramework45'
      Features            = 'SQLENGINE' # Comma-separated list of features to install. E.g. SQLENGINE,AS,IS
      InstanceName        = 'MSSQLSERVER'
      SourcePath          = $SourcePath
      SQLSysAdminAccounts = @('Administrators')
    }
  }
}

SqlServerConfiguration  -SourcePath $SourcePath -OutputPath .\SqlServerConfiguration\
