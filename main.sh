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

Main()
{
clear
## Menu de escolha ##
    echo -e "\033[1;37m\n\n#################################"
    echo "##         MENU         ##"
    echo -e "#################################\n"
    echo " [ 1 ] CALCULADORA "
    echo " [ 7 ] SAIR "
    echo -e "\n#################################\n"
    echo "Qual é a opção desejada?"
    read OPCAO
    echo -e "\033[0m"
    clear

    ## Opções da calculadora ##
    case $OPCAO in
      1)MenuCalc;;
      7)exit;;
    *)

    whiptail --title "AVISO" --msgbox "Por favor digite uma opção váilda !" 8 40
    echo ; Main ;;
  esac
}
Main
