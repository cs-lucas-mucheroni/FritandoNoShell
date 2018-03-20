#!/bin/bash
source Desafios/exec.sh
function desafios(){
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
whiptail --title "AVISO" --msgbox "Por favor digite uma opção váilda !" 8 40
echo ; desafios ;;
esac

}
