#!/bin/bash
###############################################
## Funçoes para realizar cálculos numéricos  ##
## Arquivo: menu.sh                          ##
## Autor: Lucas Mucheroni                    ##
## Inicio: 09/03/2018                        ##
## Última atualização: 09/03/2018            ##
## Autor da última atualização: Lucas        ##
###############################################

# Função de soma
function soma(){
  echo -e "\033[1;34m\n\n#################################"
  echo "##             SOMA            ##"
  echo -e "#################################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  if [[ $first = [0-9] || $second = [0-9] ]]; then
    whiptail --title "AVISO" --msgbox "Resultado da soma: $((first + second))" 8 40
  else
    whiptail --title "AVISO" --msgbox "Favor digitar uma opção válida !" 8 40
  fi
  echo -e "#################################\n \033[0m"
  Calculadora
}

# Função de subtração
function subtracao(){
  echo -e "\033[1;34m\n\n#################################"
  echo "##          SUBTRAÇÃO          ##"
  echo -e "#################################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  if [[ $first = [0-9] || $second = [0-9] ]]; then
    whiptail --title "AVISO" --msgbox "Resultado da soma: $((first - second))" 8 40
  else
    whiptail --title "AVISO" --msgbox "Favor digitar uma opção válida !" 8 40
  fi
  echo -e "#################################\n \033[0m"
  Calculadora
}

# Função de multiplicação
function multiplicacao(){
  echo -e "\033[1;34m\n\n#################################"
  echo "##        MULTIPLICAÇÃO        ##"
  echo -e "#################################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  if [[ $first = [0-9] || $second = [0-9] ]]; then
    whiptail --title "AVISO" --msgbox "Resultado da soma: $((first * second))" 8 40
  else
    whiptail --title "AVISO" --msgbox "Favor digitar uma opção válida !" 8 40
  fi
  echo -e "#################################\n\033[0m "
  Calculadora
}

# Função de divisão
function divisao(){
  echo -e "\033[1;34m\n\n#################################"
  echo "##           DIVISÃO           ##"
  echo -e "#################################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  if [[ $first = [0-9] || $second = [0-9] ]]; then
    whiptail --title "AVISO" --msgbox "Resultado da soma: $((first / second))" 8 40
  else
    whiptail --title "AVISO" --msgbox "Favor digitar uma opção válida !" 8 40
  fi
  echo -e "#################################\n\033[0m"
  Calculadora
}

# Função de Raiz Quadrada
# Para calcular a raiz quadrada de um número em Shell, use o comando bc.
# Ele é uma calculadora completa, que entre outras funções úteis, tem a sqrt (de “square root”).
function raiz(){
  echo -e "\033[1;34m\n\n#################################"
  echo "##        RAIZ QUADRADA        ##"
  echo -e "#################################\n"
  echo "Digite o valor desejado: "
  read first
  second=$(echo "sqrt($first)" | bc)
  if [[ $first = [0-9] ]]; then
    whiptail --title "AVISO" --msgbox "Resultado: $second" 8 40
  else
    whiptail --title "AVISO" --msgbox "Favor digitar uma opção válida !" 8 40
  fi
  echo -e "#################################\n\033[0m"
  Calculadora
}
