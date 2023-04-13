#gerando logs
start-transcript -Path "caminhodasuamaquina\log.txt" -append -NoClobber
Write-Host iniciando o script: (Get-Date)   

#setando as variaveis usuario e senha cripto do azure ad

$username = "seu_login@dominio.com" 
$password = Get-Content "caminhodasuamaquina\cripto1.txt" |ConvertTo-SecureString 

#setando as variaveis usuario e senha cripto do adds

$usernamead = "seuusuario"
$passwordad = Get-Content "caminhodasuamaquina\cripto2.txt" |ConvertTo-SecureString

#definindo a variavel cred e credad para automatizar o login

$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$credad = new-object -typename System.Management.Automation.PSCredential -argumentlist $usernamead, $passwordad
#testando a Conexão com o MSOL:
Connect-MsolService -Credential $cred

#Definir variáveis
$Login = ""
$Data = ""
$Loginad = ""

#Leitura do arquivo CSV
$csv = Import-Csv 'caminhodasuamaquina\colaboradores-bloqueio.csv'

#Criação da tabela
$csv | Format-Table | Out-Null

#Atribuição de valores às variáveis
foreach ($row in $csv) {
    $Login = $row.Login
    $Data = $row.data
    $Loginad = $row.Loginad

#obtenção de data   
$Date = Get-Date -Uformat “%d/%m/%y”
#comparação de data do pc com a data de bloqueio

if ($Data -eq $Date)
{  
    #Realizar o bloqueio do usuário no Azure AD
    Set-MsolUser -UserPrincipalName $Login -BlockCredential $false
    #Desabilita o usuario no adds
     Enable-ADAccount -Credential $credad $Loginad -Verbose 

#print dos logins bloqueados
 Write-Host Usuarios bloqueados: $login $Data $Loginad
}
}
#para de gerar log
stop-transcript

exit
