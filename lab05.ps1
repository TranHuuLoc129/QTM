
Get-Module ActiveDirectory

New-ADOrganizationalUnit -Name "KHOA_CNTT" -Path "DC=labtdtu,DC=com"

New-ADOrganizationalUnit -Name "Leader" -Path "OU=KHOA_CNTT,DC=labtdtu,DC=com"

New-ADOrganizationalUnit -Name "Office" -Path "OU=KHOA_CNTT,DC=labtdtu,DC=com"

New-ADOrganizationalUnit -Name "Qualification" -Path "OU=KHOA_CNTT,DC=labtdtu,DC=com"


#tao group

$group = Import-Csv C:\Users\Administrator\Group.csv

foreach ($g in $group){
    
    $name = $g.Name
    $des = $g.Description
    $OU = $g.OU

  
    New-ADGroup -Name $name -Description $des -GroupCategory Security -GroupScope Global -Path $OU

 }


 #tao cac user duoc uy quyen


$user = Import-Csv C:\Users\Administrator\User.csv

foreach ($u in $user){

    $username = $u.Username
    $password = $u.Password
    $firstname = $u.Firstname
    $lastname = $u.Lastname
    $fullname = $u.Fullname
    $department = $u.Department
    $OU = $u.OU
    $g = $u.Group
    $g2 = $u.Group2

     New-ADUser `
        -SamAccountName $username `
        -UserPrincipalName "$username@labtdtu.com" `
        -Name $fullname `
        -GivenName $firstname `
        -Surname $lastname `
        -Enabled $true `
        -ChangePasswordAtLogon $false `
        -PasswordNeverExpires $true `
        -DisplayName "$lastname, $firstname" `
        -Department $department `
        -Path $OU `
        -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) 

    
     Add-ADGroupMember -Identity $g -Members $username

     if($g2 -ne ''){
        Add-ADGroupMember -Identity $g2 -Members $username
     }


     


 }


 dsacls "OU=Qualification,OU=KHOA_CNTT,DC=LABTDTU,DC=COM" /G "LABTDTU\tutd:CCDC;user"


















