## OneDrive for Business Setup Powershell Cmdlets ##
Tenant Admin Powershell Cmdlets to trigger the creation of OneDrive for Business sites and grant tenant administrators administrative access to these sites.

### Prerequisites ###
Before you begin running the Scripts, review the following information about prerequisites:

- [Set up the SharePoint Online Management Shell environment](http://go.microsoft.com/fwlink/p/?LinkId=506693)
- [Download and install the SharePoint Online Client Components SDK](http://go.microsoft.com/fwlink/p/?LinkId=506692)

Also verify the following:

- The tenant admin is a Global Administrator in Office 365 for enterprises.
- The tenant admin is a member of the Administrators group on the server on which you are running the Windows PowerShell script.

### PreSetupOdbSites.ps1 ###
The PowerShell script contains the following cmdlets that can be made available by loading the script

    . C:\powershell\PreSetupOdbSites.ps1

The cmdlets are as follows:

	1- Add-UsersForOdbSitesCreation cmdlet
	
	Add users for OneDrive for Business site creation.
	
	2- Grant-TenantAdminPermissionsToOdbSites cmdlet
	    
	Grants the tenant administrators administrative permissions to the OneDrive for Business sites.

### Add-UsersForOdbSitesCreation cmdlet ####
Add-UsersForOdbSitesCreation cmdlet can be used to trigger the creation of users' OneDrive for Business sites. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. The creation can take up to one day to complete.

***Example:***

    Add-UsersForOdbSitesCreation -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
***Output:***

Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Add-UsersForOdbSitesCreation finished executing. Failures: [0]  

### Grant-TenantAdminPermissionsToOdbSites ####

Grant-TenantAdminPermissionsToOdbSites cmdlet grants the Tenant Admin administrative permissions to the users' OneDrive for Business sites. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. 

***Example:***

    Grant-TenantAdminPermissionsToOdbSites -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
***Output:***

Hash table with Status and the Failures of user emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Granting Tenant Admin Permissions To Odb Sites finished executing. Failures: [0]
  
