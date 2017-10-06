#REQUIRES -Version 4.0

<#
.DESCRIPTION
This is a wrapper for JAMF Pro / JSS MDM API.  I've included ONLY GET minu

#>

#Change APIBaseURL to your JSS Server typically it's https://jss.example.com:PORT/JSSResource
$APIBaseURL = "https://jss.example.com:8443/JSSResource"

#This will prompt you for the username / password to the JSS API, the credentials are only used in the Get-JSSAPICall function but all functions use that function for GET requests
$JSSAPICredentials = Get-Credential -Message "JSSAPI - Username / Password"

#Required for the Invoke-WebRequest to let the JSS API know where wanting JSON instead of XML
$JSONHeader =  @{ "Accept" = "application/json" }

#This is to log the API calls and it will store this file where the module is loaded from
$JSSLogfile = Join-Path -Path $PSScriptRoot -ChildPath "JSSAPI-Log.log"



<#
API Methods not included:

activationcode
advancedcomputersearches
advancedmobiledevicesearches
advancedusersearches
allowedfileextensions
byoprofiles
computerapplications
computerapplicationusage
computercheckin
computerextensionattributes
computerhardwaresoftwarereports
computerinventorycollection
computerinvitations
computerreports
diskencryptionconfigurations
dockitems
fileuploads
gsxconnection
healthcarelistener
healthcarelistenerrule
ibeacons
infrasturcturemanager
jssuser
jsonwebtokenconfigurations
licensedsoftware
logflush
managedpreferenceprofiles
mobiledeviceenrollmentprofiles
mobiledeviceinvitations
mobiledeviceprovisioningprofiles
netbootservers
patches
peripherals
peripheraltypes
removablemacaddresses
restrictedsoftware
savedsearches
softwareupdateservers
userextensionattributes
webhooks

#>



function Get-JSSAccounts {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $userId,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $username,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        $groupid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $groupname
    )    


    Process {
        $uri = "$($APIBaseURL)/accounts"
    
        if ($userId) {
            $uri += "/userid/$($userid)"
        } elseif ($usernamename) {
            $uri += "/name/$($username)"
        } elseif ($groupid) {
            $uri += "/groupid/$($groupid)"
        } elseif ($groupname) {
            $uri += "/groupname/$($groupname)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName accounts) {
            $response.accounts            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName account) {
            $response.account
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName group) {
            $response.group
        }
    }
}

function Get-JSSBuildings {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/buildings"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName buildings) {
            $response.buildings
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName building) {
            $response.building
        }
    }
}

function Get-JSSCategories {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/categories"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName categories) {
            $response.categories
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName category) {
            $response.category
        }
    }
}

function Get-JSSClasses {
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri =  "$($APIBaseURL)/classes"

        if ($Id) {
            $uri += "/id/$($Id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }
        
    
        $response = Get-JSSAPICall -uri $uri
         
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName classes) {            
            $response.classes
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName class) {            
            $response.class            
        }
    }
}

function Get-JSSComputerCommands {
    [CmdletBinding()]    
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $udid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]        
        $command,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $statusuuid

    )    

    Process {
        $uri = "$($APIBaseURL)/computercommands"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($command) {
            $uri += "/command/$($command)"
        } elseif ($statusuuid) {
            $uri += "/status/$($statusuuid)"
        }

        $response = Get-JSSAPICall -uri $uri
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName computer_commands) {
            $response.computer_commands
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName computer_command) {
            $response.computer_command
        }

    }
   
}

function Get-JSSComputerConfigurations {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/computerconfigurations"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName computer_configurations) {
            $response.computer_configurations
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName computer_configuration) {
            $response.computer_configuration
        }
    }
}

function Get-JSSComputerGroups {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )   


    Process {
        $uri =  "$($APIBaseURL)/computergroups"

        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }
    
        $response = Get-JSSAPICall -uri $uri
  
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName computer_groups) {            
            $response.computer_groups | Where-Object { $_.is_smart -eq $false }        
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName computer_group) {
            $response.computer_group | Where-Object { $_.is_smart -eq $false }        
        } else {
            $response
        }
    }

    End {
        write-host "Computer groups are intentionally filtered to just static groups." -ForegroundColor Yellow
    }

}

function Get-JSSComputerHistory {
    [CmdletBinding()]    
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $udid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]        
        $serialnumber,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]        
        [string]
        $macaddress,

        [parameter(Mandatory=$false, Position=1)]        
        [string]
        $subset

    )    

    Process {
        $uri = "$($APIBaseURL)/computerhistory"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($serialnumber) {
            $uri += "/serialnumber/$($serialnumber)"
        } elseif ($macaddress) {
            $uri += "/macaddress/$($macaddress)"
        } elseif ($subset) {
            throw [System.ArgumentNullException] "No parameters specified with subset"                        
        } else {
            throw [System.ArgumentNullException] "No parameters specified"
        }

        if ($subset) {
            $uri += "/subset/$($subset)"
        }
        
        
        $response = Get-JSSAPICall -uri $uri
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName computer_history) {
            $response.computers
        } else {
            $response
        }
    }
}

function Get-JSSComputerManagement {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name,

        [parameter(Mandatory=$false)]
        [string]
        $udid,

        [parameter(Mandatory=$false)]
        [string]
        $serialnumber,

        [parameter(Mandatory=$false)]
        [string]
        $macaddress

    )    
    Process {
        $uri = "$($APIBaseURL)/computermanagement"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($serialnumber) {
            $uri += "/serialnumber/$($serialnumber)"
        } elseif ($macaddress) {
            $uri += "/macaddress/$($macaddress)"
        } else {
            throw [System.ArgumentException] "No parameter specified"
        }

    
        $response = Get-JSSAPICall -uri $uri

        if (DoesPropertyExist -MyObject $response -MyPropertyName computer_management) {
            $response.computer_management
        } else {
            $response
        }
    }
}

<#

.SYNOPSIS
Get all the computers from JAMF or individual devices by specifying the id/udid/serialnumber/macaddress.  id and name are returned without parameters.  Basic information can be returned when using the subset parameters for all computers.  Full details are available when specifying parameters.

.PARAMETER id
Id of a single computer.  Id, Udid, serialnumber and macaddress are intended as a single parameters so you do not need to specify all of them, just one.  You can include the subset parameter to reduce the returned information.

.PARAMETER name
Name of a single computer.  Id, Udid, serialnumber and macaddress are intended as a single parameters so you do not need to specify all of them, just one.  You can include the subset parameter to reduce the returned information.

.PARAMETER udid
Udid of a single computer.  Id, Udid, serialnumber and macaddress are intended as a single parameters so you do not need to specify all of them, just one.  You can include the subset parameter to reduce the returned information.

.PARAMETER serialnumber
serialnumber of a single computer.  Id, Udid, serialnumber and macaddress are intended as a single parameters so you do not need to specify all of them, just one.  You can include the subset parameter to reduce the returned information.

.PARAMETER macaddress
macaddress of a single computer.  Id, Udid, serialnumber and macaddress are intended as a single parameters so you do not need to specify all of them, just one.  You can include the subset parameter to reduce the returned information.

.PARAMETER subset
Initially I was going to create this as a switch and just append /subset/basic, however it can be used when returning a single device for specific subsets, see your JSS API for the available subsets.

.EXAMPLE
Get-JSSComputers
This will return the id and name of all computers in JAMF Pro / JSS

.EXAMPLE
Get-JSSComputers -subset basic
Returns all computers with basic information which includes managed, username, model, department, building, mac_address, udid, serial_number, report_date(s).  Basic is the only subset support for all computers, this is a JSS API restriction

.EXAMPLE
Get-JSSComputers -id 1
Returns a single computer with all information

.EXAMPLE
Get-JSSComputers -id 1 -subset "general&location"
Returns a single computer with just the general and location information

.EXAMPLE
Get-JSSComputers | Get-JSSComputers
Returns all computers with all information.  This will take awhile as it will have to call the API once for every computer

.EXAMPLE
Get-JSSComputers -subset basic | where { $_.model -eq "MacBookPro11,4" } | Get-JSSComputers
Returns all the computers with basic information then filters that list to just those that are MacBook Pros of 11,4 and then gets the full details for all of those MacBooks


#>
function Get-JSSComputers {
    [CmdletBinding()]    
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0)]
        [string]
        $name,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $udid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]        
        $serialnumber,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]        
        [string]
        $macaddress,

        [parameter(Mandatory=$false, Position=1)]        
        [string]
        $subset

    )    

    Process {
        $uri = "$($APIBaseURL)/computers"
        #I couldn't get parametersets to do what I'd like so used if/elseif's.  If you don't specify id, name, udid, serial, macaddress it will get all computers with just id,name.  You can have it pull in the basic subset with all devices
        #so you can use a where filter on the basic information to pipe it back to get-computers for more details.

        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($serialnumber) {
            $uri += "/serialnumber/$($serialnumber)"
        } elseif ($macaddress) {
            $uri += "/macaddress/$($macaddress)"
        } elseif ($subset) {
            $uri += "/subset/$($subset)"
        }


        #The reason for this mess is you can do Get-Computers -subset basic without specifing id/udid/serial/mac to get basic information for all computers, if however
        #you want more than the basics for one device you would use Get-Computers -id 1 -subset "General&Location&Purchasing" 
        if ($subset -and (($id) -or ($name) -or ($udid) -or ($serialnumber) -or ($macaddress))) {
            Write-Host "hit the second subset"
            $uri += "/subset/$($subset)"

        }
        
           
        $response = Get-JSSAPICall -uri $uri
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName computers) {
            $response.computers
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName computer) {
            $response.computer
        }
    }
   

}

function Get-JSSDepartments {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/departments"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName departments) {
            $response.departments
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName department) {
            $response.department
        }
    }
}

function Get-JSSDirectoryBindings {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/directorybindings"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName directory_bindings) {
            $response.directory_bindings
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName directory_binding) {
            $response.directory_binding
        }
    }
}

function Get-JSSDistributionPoints {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/distributionpoints"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName distribution_points) {
            $response.distribution_points
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName distribution_point) {
            $response.distribution_points
        } 
    }
}

function Get-JSSEBooks {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/ebooks"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName ebooks) {
            $response.ebooks
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName ebook) {
            $response.ebook
        } 
    }
}

function Get-JSSLDAPServers {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name,

        [parameter(Mandatory=$false)]
        [string]
        $user,

        [parameter(Mandatory=$false)]
        [string]
        $group
    )    

    Process {
        $uri = "$($APIBaseURL)/ldapservers"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }

        if ($user -and -not $group -and ($id -ne $null -or $name -ne $null)) {
            $uri += "/user/$($user)"
        } 

        if ($group -and ($id -ne $null -or $name -ne $null)) {
            $uri += "/group/$($group)"
            if ($user) {
                $uri += "/user/$($user)"
            }
        } 
       

        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName ldap_servers) {
            $response.ldap_servers            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName ldap_server) {
            $response.ldap_server
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName ldap_users) {
            $response.ldap_users
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName ldap_groups) {
            $response.ldap_groups
        } 
    }
}

function Get-JSSMacApplications {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/macapplications"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName macapplications) {
            $response.macapplications
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName macapplication) {
            $response.macapplication
        }
    }
}

function Get-JSSMobileDeviceApplications {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/mobiledeviceapplications"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_applications) {
            $response.mobile_device_applications
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_application) {
            $response.mobile_device_application
        }
    }
}

function Get-JSSMobileDeviceApplicationScope {


}

function Get-JSSMobileDeviceCommands {
    [CmdletBinding()]    
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0)]
        [string]
        $name,

        [parameter(Mandatory=$false, Position=0)]
        [string]
        $udid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]        
        $command

    )    

    Process {
        $uri = "$($APIBaseURL)/mobiledevicecommands"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($command) {
            $uri += "/command/$($command)"
        }
        $response = Get-JSSAPICall -uri $uri
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_commands) {
            $response.mobile_device_commands
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_command) {
            $response.mobile_device_command
        }

    }
   
}

function Get-JSSMobileDeviceConfigurationProfiles {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/mobiledeviceconfigurationprofiles"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName configuration_profiles) {
            $response.configuration_profiles
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName configuration_profile) {
            $response.configuration_profile
        } 
    }

}

function Get-JSSMobileDeviceGroups {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/mobiledevicegroups"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_groups) {
            $response.mobile_device_groups | where { $_.is_smart -eq $false }
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device_group) {
            $response.mobile_device_group | where { $_.is_smart -eq $false }
        }
    }

    End {
        Write-Host "This will only return static groups" -ForegroundColor Yellow
    }
}

function Get-JSSMobileDevices {
    [CmdletBinding()]    
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0)]
        [string]
        $name,

        [parameter(Mandatory=$false, Position=0)]
        [string]
        $udid,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]        
        $serialnumber,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]        
        [string]
        $macaddress,

        [parameter(Mandatory=$false, Position=1)]        
        [string]
        $subset

    )    

    Process {
        $uri = "$($APIBaseURL)/mobiledevices"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        } elseif ($udid) {
            $uri += "/udid/$($udid)"
        } elseif ($serialnumber) {
            $uri += "/serialnumber/$($serialnumber)"
        } elseif ($macaddress) {
            $uri += "/macaddress/$($macaddress)"
        } elseif ($subset) {
            $uri += "/basic"
        }

        if ($subset -and ($id -ne $null -or $name -ne $null -or $udid -ne $null -or $serialnumber -ne $null -or $macaddress -ne $null)) {
            $uri += "/subset/$($subset)"
        }
        
        $response = Get-JSSAPICall -uri $uri
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName mobile_devices) {
            $response.mobile_devices
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName mobile_device) {
            $response.mobile_device
        }

    }
   
}

function Get-JSSNetworkSegments {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false)]
        [string]
        $name
    )    

    Process {
        $uri = "$($APIBaseURL)/networksegments"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName network_segments) {
            $response.network_segments
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName network_segment) {
            $response.network_segment
        }
    }
}

function Get-JSSOSXConfigurationProfiles {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/osxconfigurationprofiles"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName osx_configuration_profiles) {
            $response.osx_configuration_profiles
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName osx_configuration_profile) {
            $response.osx_configuration_profile
        } 
    }
}

function Get-JSSPackages {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/packages"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName packages) {
            $response.packages
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName package) {
            $response.package
        } 
    }
}

function Get-JSSPolicies {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/policies"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName policies) {
            $response.policies
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName policy) {
            $response.policy
        } 
    }
}

function Get-JSSPrinters {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/printers"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName printers) {
            $response.printers
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName printer) {
            $response.printer
        } 
    }
}

function Get-JSSScripts {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/scripts"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName scripts) {
            $response.scripts
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName script) {
            $response.script
        } 
    }
}

function Get-JSSSites {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/sites"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName sites) {
            $response.sites
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName site) {
            $response.site
        } 
    }
}

function Get-JSSSMTPServer {
    [CmdletBinding()]

    $uri = "$($APIBaseURL)/smtpserver"
    
    $response = Get-JSSAPICall -uri $uri
  
    if (DoesPropertyExist -MyObject $response -MyPropertyName smtp_server) {
        $response.smtp_server   
    } 
}

function Get-JSSUserGroups {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/usergroups"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName user_groups) {
            $response.user_groups
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName user_group) {
            $response.user_group
        } 
    }
}

function Get-JSSUsers {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id,

        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $name
    )    

    Process {

        $uri = "$($APIBaseURL)/users"
    
        if ($id) {
            $uri += "/id/$($id)"
        } elseif ($name) {
            $uri += "/name/$($name)"
        }


        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName users) {
            $response.users
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName user) {
            $response.user
        } 
    }
}

function Get-JSSVPPAccounts {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id
    )    

    Process {

        $uri = "$($APIBaseURL)/vppaccounts"
    
        if ($id) {
            $uri += "/id/$($id)"
        } 

        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName vpp_accounts) {
            $response.vpp_accounts
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName vpp_account) {
            $response.vpp_account
        } 
    }
}

function Get-JSSVPPAssignments {
    param(
        [parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName)]
        [int]
        [ValidateRange(1,1000000)]
        $id
    )    

    Process {

        $uri = "$($APIBaseURL)/vppassignments"
    
        if ($id) {
            $uri += "/id/$($id)"
        } 

        $response = Get-JSSAPICall -uri $uri
  
        if (DoesPropertyExist -MyObject $response -MyPropertyName vpp_assignments) {
            $response.vpp_assignments
            
        } elseif (DoesPropertyExist -MyObject $response -MyPropertyName vpp_assignment) {
            $response.vpp_assignment
        } 
    }
}


<#
.SYNOPSIS
This is the base GET used for all of the functions in this module.

.DESCRIPTION
This will prompt the first time it is called for username password and will store the credentials in $JSSAPICredentials for subsequent calls.  On Windows machines you can store the credentials to a file and read that file in when the method is called, however since I do use a Mac from time to time I cannot do that as PowerShell on other platforms doesn't have CRYPTO.DLL.

.PARAMETER uri
This is the full API method url that you are going to call which includes all parameters.  All of the GET methods here use this method.



.EXAMPLE
Get-JSSAPICall -uri "https://jss.example.com/JSSResource/computers/id/1"


#>
function Get-JSSAPICall {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true)]
        [string]
        $uri
    )   

    Write-Host $uri

    try {
        
        #$response = Invoke-WebRequest -Method Get -Uri $uri -Credential (Get-CredentialFromFile -Username $APIUsername -Path "$($PSScriptRoot)\$($APIUsername)-PowershellCreds.txt") -Headers $JSONHeader -ErrorAction SilentlyContinue
        
        $response =  Invoke-WebRequest -Method Get -Uri $uri -Credential $JSSAPICredentials -Headers $JSONHeader -ErrorAction SilentlyContinue
        
        if (DoesPropertyExist -MyObject $response -MyPropertyName StatusCode) {
            $response.Content | ConvertFrom-Json            
        }
    }
    catch {
        Write-Log -Path $JSSLogfile -Logstring $_.Exception.Message -err "1"                           
    }

}


<#
.SYNOPSIS
Records information to a file and also displays text formatted to the screen.  This will save it tab delimited and prefixes all entries with the date/time.  There are three columns:  datetime,message,error

.PARAMETER Path
Full path to the file which will be the log

.PARAMETER Logstring
information you wish to record in the log

.PARAMETER err
0 - means success, 1 - means failure, ommitting means failure

.EXAMPLE
LogWrite "This is a test" "0"

Writes current time {tab} This is a test {tab} 0 to a file and to the screen.
#>
function Write-Log {
    Param (
        [string]
        $Path,

        [string]
        $Logstring,

        [string]
        $err
    )

    $TimeDate = Get-Date -Format "yyyy-MM-dd-HH:mm:ss"
    
    $Val = [string]::join("`t",$TimeDate.ToString(), $Logstring, $err).ToString()
    
    Add-Content -Path $Path -Value $Val -ErrorAction Stop
    
    if ($err -eq "0" ) {
        Write-Host $logstring -ForegroundColor Green
    } else {
        Write-Host $Logstring -ForegroundColor DarkYellow
    }
}


<#
.SYNOPSIS
Tests to see if a propery is defined on an object.

.DESCRIPTION
Pass the object to -MyObject and the propery you want to see if exists to -MyProperty as a string

.EXAMPLE
$propExists = DoesPropertyExist -MyObject $ouUser -MyPropertyName "CustomAttribute2"
#>
Function DoesPropertyExist {
    Param (

        [parameter(Mandatory=$true)]
        [PSobject]
        $MyObject,
        
        [parameter(Mandatory=$true)]
        [string]
        $MyPropertyName
    )

    [bool]($MyObject.PSobject.Properties.name -match $MyPropertyName)
}

<#
.SYNOPSIS
Attempts to load the credential from a file, if the file doesn't exist it will prompt the user for the password with the username being the parameter passed.

.PARAMETER Username
single string that represents the user that will be used for the credential and will be a portion of the name saved to the credential path

.PARAMETER CredentialPath
single string that represents the path to where the user credential is stored.  This includes the name of the file.

.EXAMPLE
Get-CredentialFromFile -Username someuser@example.com -CredentialPath c:\users\username\powershell\credentials\someuser@example-credentials.txt

Loads the credential for someuser@example.com from path specified.  If the file doesn't exist it will prompt for the password and then save it to the credential path.

#>
function Get-CredentialFromFile {
    [CmdletBinding()]
    param(
            
        [parameter(Mandatory=$true)]
        [string]
        $Path,

        [parameter(Mandatory=$true)]
        [string]
        $Username
        

    )


    if (!(Test-Path -Path $Path)) {
        Write-Host "Credential file not found for $Username. Enter your password:" -ForegroundColor Yellow
        Read-Host -AsSecureString -Prompt "Enter password for $($Username)" | ConvertFrom-SecureString | Out-File $Path
    }

    $password = get-content $Path | convertto-securestring -ErrorAction Stop
    $Credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $Username,$password  
    
    [System.Management.Automation.PSCredential]$Credentials    

}
