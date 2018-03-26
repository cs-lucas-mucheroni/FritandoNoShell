#!/bin/bash

#Bash Labirinto versão 1.0

#Referências:
#https://www.vivaolinux.com.br/script/Jogo-de-labirinto-feito-em-shell-script/

#############################################
## Script - Jogo de Labirinto              ##
## Autor: Lucas Mucheroni                  ##
## Inicio: 12/03/2018                      ##
## Última atualização: 12/03/2018          ##
## Autor da última atualização: Lucas      ##
#############################################

function labirinto(){

# Menu inicial
setterm -cursor off

while true; do
  clear

# Comandos de como jogar
  echo -e '\033[1;37m'
  cat << EOF

 *******************************************
 **         LABIRINTO VERSÃO 1.0          **
 *******************************************
 *                                         *
 *  Comandos:                              *
 *     A -> Move para esquerda             *
 *     S -> Move para baixo                *
 *     D -> Move para direita              *
 *     W -> Mobe para cima                 *
 *     7 -> Sair do jogo                   *
 *                                         *
 *******************************************

EOF
tput sgr0
# Fim dos comandos

# Escolha de nível de dificuldade
echo -e '\033[1;37m'
cat << EOF
Selecione a dificuldade desejada:

   [ 1 ] FÁCIL
   [ 2 ] MÉDIO
   [ 3 ] DIFÍCIL
   [ 6 ] VOLTAR
   [ 7 ] SAIR DO JOGO
EOF
tput sgr0
read -n1 -s DIFICULDADE
# Fim da escolho do nível de dificuldade

# 'Case' da dificuldade
case "$DIFICULDADE" in
    "1")
      MAZE_WIDTH="39"
      MAZE_HEIGHT="21"
    break
    ;;
    "2")
      MAZE_WIDTH="49"
      MAZE_HEIGHT="31"
    break
    ;;
    "3")
      MAZE_WIDTH="59"
      MAZE_HEIGHT="41"
    break
    ;;
    "6")
      Main
      break
      ;;
    "7")
      clear
      exit 0
    ;;
  esac
done


function init_maze
{
   for ((y=0; y<MAZE_HEIGHT; y++)) ; do
      for ((x=1; x<$((MAZE_WIDTH-1)); x++)) ; do
         maze[$((y * MAZE_WIDTH + x))]=0
      done
        maze[$((y * MAZE_WIDTH + 0))]=1
        maze[$((y * MAZE_WIDTH + (MAZE_WIDTH - 1)))]=1
      done
   for ((x=0; x<MAZE_WIDTH; x++)) ; do
      maze[$x]=1
      maze[$(((MAZE_HEIGHT - 1) * MAZE_WIDTH + x))]=1
   done
}

# Mostrar a matriz do labirinto
function print_maze
{
   for ((y=0; y<MAZE_HEIGHT; y++)) ; do
      for ((x = 0; x < MAZE_WIDTH; x++ )) ; do
         if [[ maze[$((y * MAZE_WIDTH + x))] -eq 0 ]] ; then
            echo -n "[]"
         else
            echo -n "  "
         fi
      done
      echo
   done
}

# Desenha o labirinto começando no deslocamento especifico
function carve_maze
{
   local index=$1
   local dir=$RANDOM
   local i=0
   maze[$index]=1
   while [ $i -le 4 ] ; do
      local offset=0
      case $((dir % 4)) in
         0) offset=1 ;;
         1) offset=-1 ;;
         2) offset=$MAZE_WIDTH ;;
         3) offset=$((-$MAZE_WIDTH)) ;;
      esac
      local index2=$((index + offset))
      if [[ maze[$index2] -eq 0 ]] ; then
         local nindex=$((index2 + offset))
         if [[ maze[$nindex] -eq 0 ]] ; then
            maze[$index2]=1
            carve_maze $nindex
            i=0
            dir=$RANDOM
            index=$nindex
         fi
      fi
      i=$((i + 1))
      dir=$((dir + 1))
   done
}

# Gera um labirinto:
TMP="/tmp"
if [ ! -d "$TMP" ]; then
  mkdir "$TMP"
fi
init_maze
carve_maze $((2 * MAZE_WIDTH + 2))
maze[$((MAZE_WIDTH + 2))]=0
maze[$(((MAZE_HEIGHT - 2) * MAZE_WIDTH + MAZE_WIDTH - 3))]=1
print_maze > $TMP/maze.txt
sed -i '1d' $TMP/maze.txt
sed -i 's/^  //g' $TMP/maze.txt

# Inicializando variáveis
INPUT="0" # Entrada de dados
m="0" # Movimento 1
n="1" # Movimento 2
C="0" # Teste de colisões
x="5" # Coordenada x
y="2" # Coordenada y
counter="1" # Conta movimentos
GANHA="$(echo $MAZE_HEIGHT - 1 | bc)" # Detecta local da saída

# Funções para imprimir labirinto e a bola
function cat_maze() {
  echo -ne '\033[01;32m'
  cat $TMP/maze.txt
  tput sgr0
  echo -ne '\033[01;37m'
  #echo "Coordenada X = $x"
  #echo "Coordenada Y = $y"
  echo "Movimentos = $counter"

  if [ $DIFICULDADE == "1" ]; then
  {
    echo "DIFICULDADE: FÁCIL"
  }
  elif [ $DIFICULDADE == "2" ]; then
  {
    echo "DIFICULDADE: MÉDIO"
  }
  elif [ $DIFICULDADE == "3" ]; then
  {
    echo "DIFICULDADE: DIFÍCIL"
  }
  fi
  echo -e "\n\n[ 6 ] VOLTAR \n[ 7 ] SAIR DO JOGO \n\n"
}

function cat_ball()
{
  echo -ne '\033[01;31m'O
  tput sgr0
}

# Posição inicial
clear
tput cup 0 0
cat_maze
tput cup $y $x
cat_ball

# Movimentação da bola:
while [ $INPUT != "7" ];do
  read  -n1 -s INPUT
  clear

  if [ $INPUT = "6" ];then
    Main
  fi

  if [ $INPUT = a ];then
    let "m = x"
    let "n = y + 1"
    C=$(cat $TMP/maze.txt | sed -n "$n"p 2> /dev/null | cut -c"$m" 2> /dev/null)
    # Se C não estiver vazio então atingimos uma parede
    if [ -z $C ];then
      let "x = x - 1"
    else
      let counter--
    fi
  fi

  if [ $INPUT = d ];then
    let "m = x + 2"
    let "n = y + 1"
    C=$(cat $TMP/maze.txt | sed -n "$n"p 2> /dev/null | cut -c"$m" 2> /dev/null)
    # Se C não estiver vazio então atingimos uma parede
    if [ -z $C ];then
      let "x = x + 1"
    else
      let counter--
    fi
  fi

  if [ $INPUT = w ];then
    let "m = x + 1"
    let "n = y"
    C=$(cat $TMP/maze.txt | sed -n "$n"p 2> /dev/null | cut -c"$m" 2> /dev/null)
    # Se C não estiver vazio então atingimos uma parede
    if [ -z $C ];then
      let "y = y - 1"
    else
      let counter--
    fi
  fi

  if [ $INPUT = s ];then
    let "m = x + 1"
    let "n = y + 2"
    C=$(cat $TMP/maze.txt | sed -n "$n"p 2> /dev/null | cut -c"$m" 2> /dev/null)
    # Se C não estiver vazio então atingimos uma parede
    if [ -z $C ];then
      let "y = y + 1"
    else
      let counter--
    fi
  fi

  if [ "$y" -lt "0" ]; then y=0; let counter--; fi

# Checa se ganhou
if [ "$y" -gt "$GANHA" ]; then
   tput cup $(echo $MAZE_HEIGHT + 3 | bc) 0
   echo -e '\033[01;31m'
   echo -e "\n\nGANHOU !!!!! \n"
   echo "Score: $counter movimentos realizados!"
   tput sgr0
   echo
   setterm -cursor on
   exit 0
 fi

clear
cat_maze

# Imprime a bola na nova localização
tput cup $y $x
 cat_ball
 let counter++
done
clear
}
# Fim do script
