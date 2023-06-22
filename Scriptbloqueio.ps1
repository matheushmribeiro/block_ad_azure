#gerando logs
$filepath = "local dos logs"
Write-Output "--------------------------------------------------------------------------------------------------------------------------------------------------------"  | Out-File -FilePath $filepath -Append
Write-Output "iniciando o script: BLOQUEIO DE USUARIOS" (Get-Date) | Out-File -FilePath $filepath -Append

#setando variaveis do MSol

$username = "login_aqui" 
$password = Get-Content "localização_da_senha_encript" |ConvertTo-SecureString 

#setando as variaveis usuario e senha cripto do ad

$usernamead = "login_aqui"
$passwordad = Get-Content "localização_da_senha_encript" |ConvertTo-SecureString

#definindo a variavel cred para automatizar o login

$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$credad = new-object -typename System.Management.Automation.PSCredential -argumentlist $usernamead, $passwordad
#Testando a conexão com o MSOL:
Connect-MsolService -Credential $cred

#Definir variáveis
$Login = ""
$Data = ""
$Loginad = ""

#Leitura do arquivo CSV
$csv = Import-Csv 'local do csv'

#Criação da tabela e ocultando a saida dela
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
    Set-MsolUser -UserPrincipalName $Login -BlockCredential $true
    #Desabilita o usuario
     Write-Output "Operação De bloqueio No AD:" | Out-File -FilePath $filepath -Append
     Disable-ADAccount -Credential $credad $Loginad -Verbose 4>&1 | Out-File -FilePath $filepath -Append

#print dos logins bloqueados


    Write-Output "Usuario bloqueado No Azure:" $login,$Data,$Loginad | Out-File -FilePath $filepath -Append
    Write-Output " 
" | Out-File -FilePath $filepath -Append

}
}
    Write-Output "Finalizando o script:" (Get-Date) | Out-File -FilePath $filepath -Append


    Write-Output "--------------------------------------------------------------------------------------------------------------------------------------------------------"  | Out-File -FilePath $filepath -Append


#limpeza automatica do csv de cadastro de informações


#print no arquivo 
        Write-Output "Verificando a lista"  | Out-File -FilePath $filepath -Append
# Define o caminho do arquivo CSV
$csvPath = 'local do csv'
$saida = "local do csv"
# Carrega o arquivo CSV
$csv = Import-Csv $csvPath

# Define o formato de data das linhas
$dateFormat = "dd/MM/yy"

# Define a data limite de 10 dias antes da data atual
$limitDate = (Get-Date).AddDays(-10)

# Formata as colunas e tabela as informações
$csv | Select-Object @{Name="Login";Expression={$_.Login}},
                    @{Name="Data";Expression={[datetime]::ParseExact($_.Data, $dateFormat, $null)}},
                    @{Name="Loginad";Expression={$_.Loginad}} | Format-Table | Out-Null

# Define a variável booleana como false
$foundMatch ="false"

# Faz a iteração pelas linhas e verifica as datas
foreach ($row in $csv) {
    $rowDate = [datetime]::ParseExact($row.data, $dateFormat, $null)
    
    # Verifica se a data da linha é anterior à data limite
    if ($rowDate -lt $limitDate) {
         Write-Output $login $data  | Out-File -FilePath $filepath -Append

        # Remove a linha do arquivo CSV
        $csv = $csv | Where-Object { $_.Data -ne $row.Data }
        # Altere a variável booleana como true para indicar que alguma linha correspondeu à regra
        $foundMatch ="true"

    }
     
}
# Imprime uma mensagem se a variável $foundMatch ainda estiver como false
if ($foundMatch -eq "false" ) {
         Write-Output   "Nenhum login corresponde à regra" | Out-File -FilePath $filepath -Append
}


# Escreve as linhas restantes para o mesmo arquivo CSV  
$csv | ConvertTo-Csv -Delimiter "," -NoTypeInformation  | ForEach-Object { $_.Replace('"','') } | Out-File -FilePath $saida

#print no arquivo 
        Write-Output "Finalizando a Limpeza realizada na lista"  | Out-File -FilePath $filepath -Append

        Write-Output "--------------------------------------------------------------------------------------------------------------------------------------------------------"  | Out-File -FilePath $filepath -Append




exit
