## OneDriveForBusiness Setup Powershell Cmdlets ##
Tenant Admin Powershell Cmdlets to trigger the creation of OneDrive for Business sites and to grant tenant administrators administrative access to these sites.

### Before you begin ###
Before you begin running the Scripts, review the following information about prerequisites:

- [Set up the SharePoint Online Management Shell environment](http://go.microsoft.com/fwlink/p/?LinkId=506693)
- [Download and install the SharePoint Online Client Components SDK](http://go.microsoft.com/fwlink/p/?LinkId=506692)

Also verify the following:

- The tenant admin is a Global Administrator in Office 365 for enterprises.
- The tenant admin is a member of the Administrators group on the server on which you are running the Windows PowerShell script.

### PreSetupOdbSites.ps1 ###
The PowerShell script contains the following cmdlets that can be made available to the power shell by loading the script

    . C:\powershell\PreSetupOdbSites.ps1

The cmdlets are as follows:

1- Add-UsersForOdbSitesCreation cmdlet
    Add users for their OneDrive for Business Sites to be created. That can take up to one day.

2- Grant-TenantAdminPermissionsToOdbSites cmdlet
    Grant-TenantAdminPermissionsToOdbSites cmdlet grants the TenantAdmin administrative permissions to the OneDrive sites.

### Add-UsersForOdbSitesCreation cmdlet ####
    Add-UsersForMySitesCreation cmdlet can be used to trigger the creation of Users personal/MY sites. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. The creation can take up to one day to complete.

Example:

    Add-UsersForOdbSitesCreation -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
Output:

Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Add-UsersForOdbSitesCreation finished executing. Failures: [0]  

### Grant-TenantAdminPermissionsToOdbSites ####
Grant-TenantAdminPermissionsToOdbSites cmdlet grants the TenantAdmin administrative permissions to the personal sites of some users. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. 

Example:

    Grant-TenantAdminPermissionsToOdbSites -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
Output:

Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Granting Tenant Admin Permissions To Odb Sites finished executing. Failures: [0]
  
