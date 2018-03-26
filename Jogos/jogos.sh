#!/bin/bash
#############################################
## Script para realizar cálculos numéricos ##
## Autor: Lucas Mucheroni                  ##
## Inicio: 12/03/2018                      ##
## Última atualização: 12/03/2018          ##
## Autor da última atualização: Lucas      ##
#############################################

## Importando biblioteca de funções ##
source Jogos/labirinto.sh
source Jogos/forca.sh

clear
## Menu de escolha ##

function jogos
{
  Jogos()
    {
      echo -e "\033[1;37m\n\n#################################"
      echo "##        MENU DE JOGOS        ##"
      echo -e "#################################\n"
      echo " [ 1 ] LABIRINTO "
      echo " [ 2 ] FORCA "
      echo " [ 6 ] VOLTAR"
      echo " [ 7 ] SAIR "
      echo -e "\n#################################\n"
      echo "Qual é a opção desejada?"
      tput sgr0
      read -n1 -s OPCAO
      echo -e "\033[0m"
      clear

      ## Opções da calculadora ##
      case $OPCAO in
        1)labirinto;;
        2)forca;;
        6)Main;;
        7)exit;;
      *)
      #whiptail --title "AVISO" --msgbox "Por favor digite uma opção váilda !" 8 40
      echo ; Jogos ;;
    esac
  }
  Jogos
}
