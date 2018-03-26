#!/bin/bash

###############################################
## Script que execura o crono.sh é abre uma  ##
## outra janela								 ##
## Autor: Lucas Mucheroni                    ##
## Inicio: 09/03/2018                        ##
## Última atualização: 26/03/2018            ##
## Autor da última atualização: Lucas        ##
###############################################

exec(){
  open -a Terminal
  bash Desafios/crono.sh -r 00:20:00
}
