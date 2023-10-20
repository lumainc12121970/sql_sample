 Login-AzAccount 
 Select-AzureRmSubscription -SubscriptionId '8ca17755-177c-4dcb-8be1-6dec82a7ea81'
#2 Creating a credential to azure account
$cred = $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'sqladmin', $(ConvertTo-SecureString -String 'p@$$w0rd' -AsPlainText -Force))

#3 Creating a resource group
New-AzureRmResourceGroup -Name AZURESQLGROUP2 -Location 'West US'
$parameters = @{
    ResourceGroupName = 'AZURESQLGROUP2'
    ServerName = 'azuresqlserver62'
    Location = 'West US'
    SqlAdministratorCredentials = $cred
}
New-AzureRmSqlServer @parameters

#4 Creating a logical server and firewall access
$parameters = @{
    ResourceGroupName = 'AZURESQLGROUP2'
    ServerName = 'azuresqlserver62'
    FirewallRuleName = 'AllowedIps'
    StartIpAddress = '192.168.1.40'
    EndIpAddress = '192.168.1.40'
}
New-AzureRmSqlServerFirewallRule @parameters

#5 Creating a database with pricing tier
$parameters = @{
    ResourceGroupName = 'AZURESQLGROUP2'
    ServerName = 'azuresqlserver62'
   DatabaseName = 'azuresqldb3'
   RequestedServiceObjectiveName = 'BASIC'
}
New-AzureRmSqlDatabase @parameters