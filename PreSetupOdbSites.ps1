function Add-UsersForOdbSitesCreation
{
    <#
    .Synopsis
        Creation of OneDrive for Business sites for users
    
    .Description
        This cmdlet can be used to trigger the creation of Users OneDrive for Business sites. The users emails needs to be separated by commas. You can pass in a maximum of 200 users.

    .Example
        Add-UsersForOdbSitesCreation -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
    .Output
    
        Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Add-UsersForOdbSitesCreation finished executing. Failures: [0]  
    #>

    [CmdletBinding()]
    param(

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $userName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $password,

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $adminSiteUrl,

        [Parameter(
                    Mandatory=$true, 
                    ValueFromPipeline = $true, 
                    ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [string] $userIds
        )

        <#Enable if you want to import the dlls directly#>
        <#
        Import-Module 'C:\mydlls\Microsoft.SharePoint.Client.UserProfiles.dll'
        Import-Module 'C:\mydlls\Microsoft.SharePoint.Client.dll'
        #>
        
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.UserProfiles")

        $results = @{}

        if ($userName.Trim().Length -eq 0)
        {
            throw "userName parameter is empty."
        }

        if ($password.Trim().Length -eq 0)
        {
            throw "password parameter is empty."
        }

        if ($adminSiteUrl.Trim().Length -eq 0)
        {
            throw "$adminSiteUrl parameter is empty."
        }

        if ($userIds.Trim().Length -eq 0)
        {
            throw "userIds parameter is empty."
        }

	    try
	    {
            $ctx = New-Object Microsoft.SharePoint.Client.ClientContext($adminSiteUrl)
            $securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
            $ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userName,$securePassword)

            
            $profileLoader = [Microsoft.SharePoint.Client.UserProfiles.ProfileLoader]::GetProfileLoader($ctx)

            if ($profileLoader -eq $null)
            {
                throw "Unable to get ProfileLoader [$adminSiteUrl]"
            }

            $inputUserIds = @()
            
            foreach ($userId in $userIds.Split(","))
            {
                $id = $userId.Trim()
                if($id.Length -gt 0 )
                {
                    $inputUserIds += $id
                }
            }

            if ($inputUserIds.Length > 200)
            {
                throw "Number of users [$($inputUserIds.Length)] is more than 200, the maximum allowed."
            }

            Write-Host "Calling CreatePersonalSiteEnqueueBulk with [$($inputUserIds.Length)] users"
            $failedUserIds = @( $profileLoader.CreatePersonalSiteEnqueueBulk($inputUserIds) )

            $msg = "Add-UsersForOdbSitesCreation finished executing. Failures: [$($failedUserIds.Length)]"
            Write-Host $msg 
            Write-Host "Failed users: $failedUserIds" 
            $results["Status"] = $msg
            $results["Failures"] = $failedUserIds -Join ","

            return $results
	    }
        catch
        {
            Write-Host $_.Exception.ToString()
            throw $_
        }
}


function Grant-TenantAdminPermissionsToOdbSites
{
    <#       
    .Synopsis
        Grants the Tenant Admin permission to the OneDrive for Business sites of some users
    
    .Description
        Grants the TenantAdmin administrative permissions to the OneDrive for Business sites of some users. The users emails needs to be separated by commas. You can pass in a maximum of 200 users.
    
    .Example
        Grant-TenantAdminPermissionsToOdbSites -userName "admin@contoso.onmicrosoft.com" -password "December2015" -adminSiteUrl "https://contoso-admin.sharepoint.com" -userIds "user1@contoso.onmicrosoft.com,user2@contoso.onmicrosoft.com"
    
    .Output
    
        Hash table with Status and the Failures of User emails separated by commas

        Name                           Value                                                                                                                                                                                                                             
        ----                           -----                                                                                                                                                                                                                             
        Failures                                                                                                                                                                                                                                                         
        Status                         Granting Tenant Admin Permissions To Odb Sites finished executing. Failures: [0]
    #>

    [CmdletBinding()]
    param(

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $userName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $password,

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string] $adminSiteUrl,

        [Parameter(
                    Mandatory=$true, 
                    ValueFromPipeline = $true, 
                    ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [string] $userIds
        )

        <#Enable if you want to import the dlls directly#>
        <#
        Import-Module 'C:\mydlls\Microsoft.SharePoint.Client.UserProfiles.dll'
        Import-Module 'C:\mydlls\Microsoft.SharePoint.Client.dll'
        #>
       
        
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.UserProfiles")
        

        $results = @{}

        if ($userName.Trim().Length -eq 0)
        {
            throw "userName parameter is empty."
        }

        if ($password.Trim().Length -eq 0)
        {
            throw "password parameter is empty."
        }

        if ($adminSiteUrl.Trim().Length -eq 0)
        {
            throw "adminSiteUrl parameter is empty."
        }

        if ($userIds.Trim().Length -eq 0)
        {
            throw "userIds parameter is empty."
        }

	    try
	    {
            $cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $password -asplaintext -force)
            Connect-SPOService -Url $adminSiteUrl -Credential $cred

            $ctx = New-Object Microsoft.SharePoint.Client.ClientContext($adminSiteUrl)
            $securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
            $ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userName,$securePassword)
            
            
            $peopleManager = New-Object Microsoft.SharePoint.Client.UserProfiles.PeopleManager($ctx)
            $ctx.ExecuteQuery();

            if ($peopleManager -eq $null)
            {
                throw "Unable to get peopleManager [$adminSiteUrl]"
            }

            $inputUserIds = @()
            
            foreach ($userId in $userIds.Split(","))
            {
                $id = $userId.Trim()
                if($id.Length -gt 0 )
                {
                    $inputUserIds += $id
                }
            }

            if ($inputUserIds.Length > 200)
            {
                throw "Number of users [$($inputUserIds.Length)] is more than 200, the maximum allowed."
            }

            $failedUserIds = @()

            Write-Host "Calling GetPropertiesFor with [$($inputUserIds.Length)] users"
            foreach ($inputUserId in $inputUserIds)
            {
                try
                {
                    if ($inputUserIds -notcontains "i:0#.f|membership|")
                    {
                        $inputUserId = "i:0#.f|membership|" + $inputUserId
                    }

                    $personProperties  = $peopleManager.GetPropertiesFor($inputUserId)
                    $ctx.Load($personProperties);
                    $ctx.ExecuteQuery();

                    if ($personProperties -eq $null)
                    {
                        throw "Unable to get the PersonProperties for user [$inputUserId]"
                    }
                    
                    if ($personProperties.PersonalUrl -eq $null)
                    {
                        throw "Unable to get the Personal Site Url for user [$inputUserId]"
                    }

                    Set-SPOUser -Site $PersonProperties.PersonalUrl -LoginName $userName -IsSiteCollectionAdmin $true | Out-Null
                }
                catch
                {
                    Write-Host $_.Exception.ToString()
                    $failedUserIds += $id
                }                
            }

            $msg = "Granting Tenant Admin Permissions To Odb Sites finished executing. Failures: [$($failedUserIds.Length)]"
            Write-Host $msg 
            Write-Host "Failed users: $failedUserIds" 
            $results["Status"] = $msg
            $results["Failures"] = $failedUserIds -Join ","

            return $results
	    }
        catch
        {
            Write-Host $_.Exception.ToString()
            throw $_
        }
}