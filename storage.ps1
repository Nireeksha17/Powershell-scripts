﻿$rg = 'arm-introduction'
New-AzResourceGroup -Name $rg -Location eastus -Force

New-AzResourceGroupDeployment`
    -Name 'new-storage' `
    -ResourceGroupName $rg `
    -TemplateFile 'storage.json'