#!/bin/bash
#############################################
## Script para realizar cálculos numéricos ##
## Autor: Lucas Mucheroni                  ##
## Inicio: 09/03/2018                      ##
## Última atualização: 09/03/2018          ##
## Autor da última atualização: Lucas      ##
#############################################

## Importando biblioteca de funções ##
source Calculadora/calc.sh
source Jogos/jogos.sh
source Desafios/desafios.sh
Main()
{
clear
## Menu de escolha ##
    echo -e "\033[1;37m\n\n#################################"
    echo "##        MENU PRINCIPAL       ##"
    echo -e "#################################\n"
    echo " [ 1 ] CALCULADORA"
    echo " [ 2 ] JOGOS"
    echo " [ 3 ] DESAFIOS"
    echo " [ 7 ] SAIR"
    echo -e "\n#################################\n"
    echo "Qual é a opção desejada?"
    tput sgr0
    read -n1 -s OPCAO
    echo -e "\033[0m"
    clear

    ## Opções da calculadora ##
    case $OPCAO in
      1)menucalculadora;;
      2)jogos;;
      3)desafios;;
      7)exit;;
    *)

    whiptail --title "AVISO" --msgbox "Por favor digite uma opção válida !" 8 40
    echo ; Main ;;
  esac
}
Main
