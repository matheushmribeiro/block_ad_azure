####################Script Automatizado de bloqueio e desbloqueio de usuarios#####################
				Script para automatizar o bloqueio e desbloqueio de usuarios no azure ad e AD DS, por meio dele vc pode cadastrar uma lista de logins para que seja feita o blqoueio ou desbloqueio na data cadastrada
        Feito no Powershell
        
        
        
        
        primeiramente instale o "RSAT"
				execute apos isso o "chama 1exec.bat em modo de admin" para gerar a chave criptografada e baixar os modulos
				cadastre os logins para bloqueio dentro do arquivo "colaboradores-bloqueio.csv" e "colaboradores-desbloqueio.csv"" com os seguintes parametros 
				
	      	##use separador "," primeiro o email do 365 , data mes e ano abreviados e login do ad##
		      ##modelo: email_do_365@e-auditoria.com.br,01/01/23,teste.ad##
				  vc pode acompanhar pelo "log.txt" a realização dos bloqueios
				  vc pode agendar no agendador de tarefas o "chama bloqueio" e "chama desbloqueio" para realizar a tarefa diariamente
