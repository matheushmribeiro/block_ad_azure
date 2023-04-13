#setando a execução de scripts nao assinados

Set-ExecutionPolicy Unrestricted

#importando e instalando os modulos 

Install-Module -Name AzureAD
Import-Module  AzureAD
Install-Module MSOnline
Import-Module  MSOnline
Import-Module ActiveDirectory 

#Convert Password to encrypted text: 
#One time use command once it is used, you don't need it again in any automation script.
$Convertpassword = 'suasenhaaqui'| ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "caminhodasuamaquina\cripto1.txt"
$Convertpasswordad = 'suasenhaaqui'| ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "caminhodasuamaquina\cripto2.txt"

#testando a conexão

$username = "seuloginaqui" 
$password = Get-Content "caminhodasuamaquina\cripto1.txt" |ConvertTo-SecureString 

$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
Connect-MsolService -Credential $cred
