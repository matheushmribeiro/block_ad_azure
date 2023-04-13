####################Script Automatizado de bloqueio e desbloqueio de usuarios#####################
				Script para automatizar o bloqueio e desbloqueio de usuarios no azure ad e AD DS, por meio dele vc pode cadastrar uma lista de logins para que seja feita o blqoueio ou desbloqueio na data cadastrada, criptografa sua autenticação para a conexão. Vc pode criar uma tarefa no agendador de tarefas para rodar em um horario predefinido
        Feito no Powershell
        Siga os passos abaixo:
        
        1.primeiramente instale o "RSAT" na maquina que irá rodar o script
	2.no script "script1exec" cadastre as senhas que deseja criptografar, as hashs ficam armazenadas no arquivo "cripto1.txt" e "cripto2.txt"
	3.execute apos isso o "1exec.bat" como admin para gerar a chave criptografada e baixar os modulos
	4.no script "scriptbloqueio" e "scriptdesbloqueio" é necessario passar o login nas variaveis $username e $usernamead
	5.cadastre os logins para bloqueio dentro do arquivo "colaboradores-bloqueio.csv" e "colaboradores-desbloqueio.csv"" com os seguintes parametros:	
			##use separador "," primeiro o email do 365 , data mes e ano abreviados e login do ad##
			## data no formato dd/mm/aa ##
			## usuario no ad com o formato adotado, exemplo: nome.sobrenome
		      	##modelo: email_do_365@dominio.com,01/01/23,teste.ad##
	6.vc pode acompanhar pelo "log.txt" a realização dos bloqueios
	7.vc pode agendar no agendador de tarefas o "bloqueio.bat" e "desbloqueio.bat" para realizar a tarefa diariamente
