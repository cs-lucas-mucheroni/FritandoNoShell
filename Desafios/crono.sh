#!/bin/bash

###############################################
## Script de Cronômetro, assim que for       ##
## selecionado a opção de desafio, o mesmo   ##
## irá começar a contar                      ##
## Autor: Lucas Mucheroni                    ##
## Inicio: 09/03/2018                        ##
## Última atualização: 26/03/2018            ##
## Autor da última atualização: Lucas        ##
###############################################

#### Função que faz a conversão do tempo de segundos para o formato hh:mm:ss
calcula_tempo(){

  if [ $TEMPO -lt 60 ] ; then
    HORAS=0
    MINUTOS=0
    SEGUNDOS=$TEMPO

  elif [ $TEMPO -lt 3600 ] ; then
    HORAS=0
    MINUTOS=$(($TEMPO / 60))
    SEGUNDOS=$(($TEMPO % 60))

  else
    HORAS=$(($TEMPO / 3600))
    RESTO=$(($TEMPO % 3600))
    MINUTOS=$(($RESTO / 60))
    SEGUNDOS=$(($RESTO % 60))

  fi

  ## Após calculado o tempo, formata a saída para o padrão de 2 dígitos
  HORASF=$(printf '%.2d' $HORAS)
  MINUTOSF=$(printf '%.2d' $MINUTOS)
  SEGUNDOSF=$(printf '%.2d' $SEGUNDOS)
}

## Função principal que atualiza o tempo na tela automaticamente
conta_tempo(){
clear

## Se o operador não for negativo, define variável $TEMPO como -1
[ "$OP" = '-' ] || { TEMPO=-1 ; }

## Início do laço que atualiza o tempo na tela
while [ "$TECLA" != '(f|p)' ] && [ "$TEMPO_FINAL" -gt 0 ]
do

clear

  TEMPO=$(($TEMPO $OP 1))
  TEMPO_FINAL=$(($TEMPO_FINAL - 1))

  # Chamada da função que converte o tempo para o formato hh:mm:ss a cada ciclo
  # do loop.
calcula_tempo

  ## Feito os calculos, imprime na tela
  echo -e "........................."
  echo -e "START: $HORASF:$MINUTOSF:$SEGUNDOSF"
  echo -e "........................."
  echo -e "[f]inalizar desafio"
  echo -e "........................."
  
  read -n1 -t 1 TECLA  # Aguarda 1 segundo pela tecla, se não, continua

   # Conforme a tecla digitada, direciona para a função específica
  case "$TECLA" in
    f) finalizar ;;
    #p) pausar ;;
    [[:alnum:]]) sleep 1 && continue ;; # Qualquer tecla exceto f e p,
  esac
done
finalizar
}

### Função que mostra a tela final depois de encerrado o script
finalizar(){
clear

  echo -e "DESAFIO FINALIZADO FALTANDO: $HORASF:$MINUTOSF:\
  $SEGUNDOSF"

  exit 0
}


### Função que faz pausa no tempo
pausar(){

while [ "$TECLA" != 'c' ] ; do
clear

  echo -e "........................."
  echo -e "PAUSE: $HORASF:$MINUTOSF:$SEGUNDOSF"
  echo -e "........................."
  echo -e "[c]ontinuar \ [f]inalizar"
  echo -e "........................."

  read -n1 -t 1 TECLA
    
  case "$TECLA" in
   f) finalizar ;;
   esac
done
}


### Função que testa e converte o parâmetro '$2' para segundos
teste_par2() {

  ## Testa formato de tempo passado no parâmetro 2. Deve ser hh:mm:ss
  [[ "$TEMPO_LIMITE" != [0-9][0-9]:[0-5][0-9]:[0-5][0-9] ]] && \
  echo "Tempo deve ser passado no formato hh:mm:ss" && exit 1

  ## Passado no teste do parâmetro '$2' faz a conversão para segundos
  HORAS=$(echo $TEMPO_LIMITE | cut -d : -f 1) && HORAS=$(($HORAS * 3600))
  MINUTOS=$(echo $TEMPO_LIMITE | cut -d : -f 2) && MINUTOS=$(($MINUTOS * 60))
  SEGUNDOS=$(echo $TEMPO_LIMITE | cut -d : -f 3)
  TEMPO=$(($HORAS+$MINUTOS+$SEGUNDOS+1))

  TEMPO_FINAL=$TEMPO
  conta_tempo
}

#################[ Tratamento das opções de linha de comando ]###############

# Testa se foi passado parâmetro '$1'
[ "$1" ] || { opcoes_de_uso ; }

# Passado parâmetro '$1', faz o tratamento do mesmo
while test -n "$1"
do

   case "$1" in

    -p | --progressive)
   OP=+ ; TEMPO=-1
   # Se tiver parâmetro 2, chama a funçao para teste do mesmo, caso não
   # tenha, define as variáveis e chama direto a função conta_tempo
   [ "$2" ] || { TEMPO_FINAL=999999 ; conta_tempo ; }
   TEMPO_LIMITE=$2 && teste_par2
   ;;

   -r | --regressive)
   # Testa se foi passado o parâmetro $2, que neste caso é obrigatório
   [ "$2" ] || { echo "Necessário informar o tempo inicial para \
  início da contagem regressiva" ; exit 1 ; }
   TEMPO_LIMITE=$2 ; OP=- && teste_par2
   ;;

   -h | --help) opcoes_de_uso ;;
   -V | --version) versao ;;
        *) opcoes_de_uso ;;

   esac

done
