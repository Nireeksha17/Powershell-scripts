
#path of CSV file to import users 
$Users = Import-Csv -Path "D:\Userlist.csv" #            
foreach ($User in $Users)            
{            
    $Displayname = $User.'Firstname' + " " + $User.'Lastname'            
    $UserFirstname = $User.'Firstname'            
    $UserLastname = $User.'Lastname' 
    #ou = Organisational Unit               
    $OU = $User.'OU'        
    
    #SAM =  Security Account Manager (SAM) database to store user account information
    $SAM = $User.'SAM'            
    #UPN = User Principal Name
    $UPN = $User.'Firstname' + "." + $User.'Lastname' + "@" + $User.'Maildomain'            
    $Description = $User.'Description'            
    $Password = $User.'Password'            
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName $SAM -UserPrincipalName $UPN -GivenName "$UserFirstname" -Surname "$UserLastname" -Description "$Description" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $true -server domain.loc            
}
 
