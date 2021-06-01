$filename = read-host -prompt "Paste the UNC of the folder to be queried" #"\\server\shared\FOLDER"
$user = read-host -prompt "Enter the username to be traced" #"username"

$groups = ([ADSISEARCHER]"samaccountname=$($user)").Findone().Properties.memberof -replace '^CN=([^,]+).+$','$1'
$acls = (get-acl $fileName).access
$aclNames = $acls.identityreference.Value
$aclsForUser = $aclNames | sls $groups | %{$_.tostring()}
$acls | ? IdentityReference -in $aclsForUser
