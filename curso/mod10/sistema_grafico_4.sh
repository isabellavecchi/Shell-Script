#!/bin/bash

#Função Cancelar

#VARIÁVEIS
ARQ_BD="banco_de_dados.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
RST="\033[0m"

SEP=:
TEMP=:temp.$$

#TESTES

#arquivo existe?
[ ! -f "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não existe." && exit 1
[ ! -r "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de leitura." && exit 1
[ ! -w "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de escrita." && exit 1

        #install dialog

#dialog instalado?
[ ! -x "$(dialog --version)" ] && sudo apt-get install dialog 1> /dev/null 2>&1
    # 1> tá mandando a saída de texto de instalação para o /dev/null que é um buraco negro
    # para jogar fora e destruir iformações
    # 2> tá mandando pro mesmo lugar que o 1>       (REDIRECIONAMENTO DE COMANDOS)

#FUNÇÕES
ListaUsuarios () {
    egrep -v "^#|^$" "$ARQ_BD" | tr : ' ' > "$TEMP"
    #comentários ou linhas em branco n são pegas | troca : por espaço ' '

    dialog --title "Lista de Usuários" --textbox "$TEMP" 0 0
        # 0 0 = tamanho default e variável escolhido pelo programa
    
    rm -f "$TEMP"
}

ValidaUsuario () {
    grep -i -q "$1$SEP" "$ARQ_BD"
}


RemoveUsuario () {
    
    OrdenaLista
}

OrdenaLista () {
    sort -h "$ARQ_BD" > "$TEMP"
    mv "$TEMP" "$ARQ_BD"
}

#EXECUÇÃO
while : #loop infinito
do
    acao=$(dialog   --title "Gerenciamento de Usuários 2.0" \
                    --stdout --menu "Escolha uma das opções abaixo:" \
                    0 0 0 \
                    listar "Listar todos os usuários do sistema" \
                    inserir "Inserir um novo usuário" \
                    remover "Remover um usuário do sistema")
    
    [ $? -ne 0 ] && exit
        #apertou CANCELAR, para

    case $acao in
        listar)
            ListaUsuarios ;;
        inserir)
        ################################ INSERIR ##################################
            ultimo_id="$(egrep -v "^#|^$" $ARQ_BD | tail -n 1 | cut -d $SEP -f 1)"
            proximo_id=$(($ultimo_id+1))

            nome=$(dialog --title "Cadastro de Usuários" --stdout --inputbox "Digite o seu nome" 0 0)
                        
                #CANCELAR
            [ $? -ne 0 ] && continue
                    #se for cancelar, vai para o próximo loop do while
                    #LOGO DEPOIS DO DIALOG

            [ ! "$nome" ] && {
                dialog --title "ERRO" --msgbox "Nenhum nome digitado" 6 40
                exit 1
            }
            ValidaUsuario "$nome" && {
                dialog --title "ERRO" --msgbox "Usuário já existente" 6 40
                exit 1
            }

            email=$(dialog --title "Cadastro de Usuários" --stdout --inputbox "Digite o seu email" 0 0)

            echo "$proximo_id$SEP$nome$SEP$email" >> "$ARQ_BD"
            dialog --title "SUCESSO!" --msgbox "Usuário cadastrado com sucesso" 6 40 ;;
        remover)
        ################################ REMOVER ##################################
            #Colocando no formato do menu para acessar via id
            usuarios=$(egrep "^#|^$" -v "$ARQ_BD" | sort -h | cut -d $SEP -f 1,2 | sed 's/:/ "/;s/$/"/')
            id_rm=$(eval dialog --stdout --menu \"Escolha um usuário:\" 0 0 0 $usuarios)
            [ $? -ne 0 ] && continue

            grep -i -v "$id_rm$SEP" "$ARQ_BD" > "$TEMP"
            #-v é a negativa do resultado, como o ! ou ^
            #manda o resultado sem o usuário para o arquivo temporário
            mv "$TEMP" "$ARQ_BD"

            #aparece e some
            dialog --title "SUCESSO!" --msgbox "Usuário $nome removido do banco." ;;
    esac
done
