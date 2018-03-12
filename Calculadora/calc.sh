#!/bin/bash
#############################################
## Script para realizar cálculos numéricos ##
## Autor: Lucas Mucheroni                  ##
## Inicio: 09/03/2018                      ##
## Última atualização: 09/03/2018          ##
## Autor da última atualização: Lucas      ##
#############################################

## Importando biblioteca de funções ##
source Calculadora/funcoes.sh

clear
## Menu de escolha ##

function MenuCalc
{
  Calculadora()
    {
      echo -e "\033[1;37m\n\n#################################"
      echo "##         CALCULADORA         ##"
      echo -e "#################################\n"
      echo " [ 1 ] SOMA "
      echo " [ 2 ] SUBTRAÇÃO "
      echo " [ 3 ] MULTIPLICAÇÃO "
      echo " [ 4 ] DIVISÃO"
      echo " [ 5 ] RAIZ QUADRADA"
      echo " [ 6 ] VOLTAR"
      echo " [ 7 ] SAIR "
      echo -e "\n#################################\n"
      echo "Qual é a opção desejada?"
      read OPCAO
      echo -e "\033[0m"
      clear

      ## Opções da calculadora ##
      case $OPCAO in
        1)soma;;
        2)subtracao;;
        3)multiplicacao;;
        4)divisao;;
        5)raiz;;
        6)Main;;
        7)exit;;
      *)
      whiptail --title "AVISO" --msgbox "Por favor digite uma opção váilda !" 8 40
      echo ; Calculadora ;;
    esac
  }
  Calculadora
}
