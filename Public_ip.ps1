$rgName = "RG_NireekshaPk_DEV"

$nsgName = "useastdev"

$ruleName = "HTTP"
$ruleDescription = "Allow Inbound HTTP"
$rulePort = 80
$rulePriority = 100

Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName -ErrorVariable isNSGExist -ErrorAction SilentlyContinue


If (!$isNSGExist) 
{
    Write-Output "Network Security Group exist"
    

    Write-Verbose "Fetching Network Security Group: {$nsgName}"
    $nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName



    Write-Verbose "Creating network security rule: {$ruleName} (Port: {$rulePort})"


    $nsg | `
    
    Add-AzureRmNetworkSecurityRuleConfig `
        -Name $ruleName `
        -Description $ruleDescription `
        -DestinationPortRange $rulePort `
        -Priority $rulePriority `
        -Access Allow `
        -Direction Inbound `
        -Protocol Tcp `
        -SourceAddressPrefix * `
        -DestinationAddressPrefix * `
        -SourcePortRange * | ` 
    
    Set-AzureRmNetworkSecurityGroup
} 
Else 
{
    Write-Output "Network Security Group does not exist"
}