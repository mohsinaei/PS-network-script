<#
  This script is written by Mohammad Sinaei
  On December 09, 2022
  Thank you for using it ...

 #>

 # check the version of PS
 $PSVersionTable.PSVersion

 ""
 Start-Sleep -s 3

 ""

 # get the current user
 $me = whoami

 $Admins = Get-LocalGroupMember -Name Administrators | Select-Object -ExpandProperty name
  if ($Admins -Contains $me) {
      "$me is a local administrator"} 
    else {
     "$me is NOT a local administrator"}


 ""
 Start-Sleep -s 3

 ""

Get-NetIPInterface | Format-Table

 ""
 ""

 $id= Read-Host -Prompt "Enter the network interface index"
 $ip= Read-Host -Prompt "Enter the IP address"
 $mask= Read-Host -Prompt "Enter the network mask like 24"

 $com_ip = $ip, $mask 

 Write-Host "The IP address will be set as: " $com_ip , "on network adapter:", $id -ForegroundColor Green


New-NetIPAddress -InterfaceIndex $id -IPAddress $ip -PrefixLength $mask




# domain and workgroup connections








# restart the computer

function reset {

$reset = Read-Host "Do you want to restart the computer to update the changes? Type 'y' or 'n'"

if ($reset -eq 'y') {
    Restart-Computer
}
else {
  set-domain
}

}


function set-domain {
  $d = Read-Host "Do you want to connect to a domain? Type 'y' or 'n'"

if ($d -eq 'y') {
    $domain= Read-Host -Prompt "Enter the domain here"
    Add-Computer -DomainName $domain -Restart
}
else {
  reset
}
  
}



function set-workgroup {
  $w = Read-Host -Prompt "Do you want to set a workgroup? Type 'y' or 'n'"
if ($w -eq 'y') {
    $wg= Read-Host -Prompt "Enter the workgroup name here" 
    Add-Computer -WorkgroupName $wg
}
else {
  set-domain
} 
  
}

set-workgroup

