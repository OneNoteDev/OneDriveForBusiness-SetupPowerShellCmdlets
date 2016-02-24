## OneDriveForBusiness Setup Powershell Cmdlets
Tenant Admin Powershell Cmdlets to trigger the creation of users' OneDrives and to grant tenant administrators administrative access to these sites.

Before you begin
Before you begin running the Scripts, review the following information about prerequisites:
•	Set up the SharePoint Online Management Shell environment.
	http://go.microsoft.com/fwlink/p/?LinkId=506693
•	Download and install the SharePoint Online Client Components SDK.
	http://go.microsoft.com/fwlink/p/?LinkId=506692

Also verify the following:
•	The tenant admin is a Global Administrator in Office 365 for enterprises.
•	The tenant admin is a member of the Administrators group on the server on which you are running the Windows PowerShell script.

PreSetupOdbSites.ps1
These cmdlets will help Tenant Admins create the users' One Drive for business. The following cmdlets need to run:

1- Make the following functions available to the power shell, such as
. C:\powershell\PreSetupOdbSites.ps1

2- Add-UsersForOdbSitesCreation cmdlet
Add users for their OneDrive for Business Sites to be created

3- Grant-TenantAdminPermissionsToOdbSites cmdlet
Grant-TenantAdminPermissionsToOdbSites cmdlet grants the TenantAdmin administrative permissions to the OneDrive sites of some users.

##Add-UsersForMySitesCreation cmdlet
Description:
Add-UsersForMySitesCreation cmdlet can be used to trigger the creation of Users personal/MY sites. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. The creation can take up to one day to complete.

Example:
Add-UsersForOdbSitesCreation -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
Output:
Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Add-UsersForOdbSitesCreation finished executing. Failures: [0]  

##Grant-TenantAdminPermissionsToOdbSites
Description:
Grant-TenantAdminPermissionsToOdbSites cmdlet grants the TenantAdmin administrative permissions to the personal sites of some users. The users’ emails need to be separated by commas. You can pass in a maximum of 200 users. 

Example:
Grant-TenantAdminPermissionsToOdbSites -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
Output: 
Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Granting Tenant Admin Permissions To Odb Sites finished executing. Failures: [0]
  
