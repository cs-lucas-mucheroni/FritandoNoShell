#!/bin/bash

###############################################
## Apenas irá mostrar os desafios            ##
## Autor: Lucas Mucheroni                    ##
## Inicio: 09/03/2018                        ##
## Última atualização: 26/03/2018            ##
## Autor da última atualização: Lucas        ##
###############################################

## O script que irá executar o tempo e abrir uma nova janela
source Desafios/exec.sh

function desafios(){
echo -e "\033[1;37m"
cat << EOF

DESAFIOS

Escolha umas dos desafios abaixo:

Qual a cotação do dólar?
Qual o resultado da Mega Sena?
Quando começa o horário de verão?
Gere uma senha com letras e números aleatórios, com trinta digitos.
Qual o dia da semana que você nasceu?

Regras:


---
EOF

echo -e "\n\n[ 6 ] VOLTAR \n[ 7 ] SAIR DO JOGO \n[ 8 ] REALIZAR DESAFIO \n\n"
tput sgr0
read -n1 -s OPCAO
clear

case $OPCAO in
  6)Main;;
  7)exit;;
  8)exec;;
*)

echo ; desafios ;;
esac

}
