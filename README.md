# Install-SqlServer

This repository serves as an example for automating the process of installing SQL Server using PowerShell Desired State Configuration as described in [this blog post](https://joeydavis.me/sql-server-installation-with-powershell).

The example provides the ability run the command below in order to install SQL Server:

```powershell
.\Install-SqlServer.ps1 -ImagePath 'C:\en_sql_server_2017_developer_x64_dvd_11296168.iso' -SourcePath 'C:\SQLServer\'
```

Steps for using the script:

1. Modify `SqlServerConfiguration.ps1` to match the desired `SqlSetup` configuration.
2. Copy `Install-SqlServer.ps1`, `SqlServerConfiguration.ps1`, and the SQL Server installation media to the target server.
2. Execute `Install-SqlServer.ps1`, passing the required `ImagePath` and `SourcePath` parameters. Documentation for these parameters may be seen in the file.


## `SqlSetup`

Documentation for SqlSetup is available here https://github.com/PowerShell/SqlServerDsc#sqlsetup.

https://github.com/PowerShell/SqlServerDsc/tree/dev/Examples/Resources/SqlSetup.


## SQL Server Feature Abbreviations (used in `SqlSetup`)

These abbreviations are used in the `SqlServerConfiguration.ps1` to specify which features to install.

This list may not be up to date or certain abbreviations may not be supported by `SqlSetup`. Please check the documentation for SqlSetup in order to determine which features are supported.

- Analysis services = `AS`
- Client tools backwards compatibility = `BC`
- Client tools connectivity = `CONN`
- Client tools SDK = `SDK`
- Data quality client = `DQC`
- Data quality services = `DQ`
- Database engine = `SQLENGINE`
- Distributed replay client = `DREPLAY_CLT`
- Distributed replay controller = `DREPLAY_CTLR`
- Documentation components = `BOL`
- Full-text and semantic extractions for search = `FULLTEXT`
- Integration services = `IS`
- Management tools – advanced = `ADV_SSMS`
- Management tools – basic = `SSMS`
- Master data services = `MDS`
- Replication = `REPLICATION`
- Reporting services – native = `RS`
- Reporting services – sharepoint = `RS_SHP`
- Reporting services add-in for sharepoint products = `RS_SHPWFE`
- SQL client connectivity SDK = `SNAC_SDK`
- SQL Server data tools = `BIDS`
