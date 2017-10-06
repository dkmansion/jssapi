# jssapi
This is a PowerShell wrapper for most of the JAMF MDM API.

The following functions wrap the corresponding JAMF Pro API which you can find on you local JSS Server via https://jss.example.com:port/api.

Get-JSSAccounts

Get-JSSBuildings

Get-JSSCategories

Get-JSSClasses

Get-JSSComputerCommands

Get-JSSComputerConfigurations

Get-JSSComputerGroups

Get-JSSComputerHistory

Get-JSSComputerManagement

Get-JSSComputers

Get-JSSDepartments

Get-JSSDirectoryBindings

Get-JSSDistributionPoints

Get-JSSEBooks

Get-JSSLDAPServers

Get-JSSMacApplications

Get-JSSMobileDeviceApplications

Get-JSSMobileDeviceApplicationScope

Get-JSSMobileDeviceCommands

Get-JSSMobileDeviceConfigurationProfiles

Get-JSSMobileDeviceGroups

Get-JSSMobileDevices

Get-JSSNetworkSegments

Get-JSSOSXConfigurationProfiles

Get-JSSPackages

Get-JSSPolicies

Get-JSSPrinters

Get-JSSScripts

Get-JSSSites

Get-JSSSMTPServer

Get-JSSUserGroups

Get-JSSUsers

Get-JSSVPPAccounts

Get-JSSVPPAssignments

All of the functions support the PowerShell pipeline.

I've only added help on the Get-JSSComputers, however I followed the API on all of the methods.

I didn't include POST, PUT or DELETE methods as all of them can be very destructive.

When using Get-JSSComputerGroups or Get-JSSMobileDeviceGroups I filter out smart groups so if you aren't seeing all the groups you will want to remove the where clause in the function. I do not suggest removing the filter if you are going to use POST/PUT/DELETE to change membership as smart groups are criteria based.
