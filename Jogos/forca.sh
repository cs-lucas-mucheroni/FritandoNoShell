#!/bin/bash
#
# jogodaforca.sh 	: Jogo da Forca - GNU EDITION
#
# Site				: http://www.terminalroot.com.br/
# Autor				: Marcos da B. M. Oliveira <binbash@linuxmail.org>
#
#---------------------------------------------------------------------------------
#
# Este é o famoso Jogo da Forca , mas escrito em Shell Script , feito pra Linux e
# roda no Terminal.
#
# Exemplo:
# $ ./jogodaforca.sh
# Pressionando CTRL+E ele reseta o jogo.
# Pressionando CTRL+A ele sai do jogo
#
#
# v1.0 2015-08-12 , Marcos Oliveira:
#		- Versão inicial , jogo funcionando
#FIXME 	- O jogo gera BUG quando o número de letras de uma palavra é maior que 10
#		  e não aceita palavras que possuem acento.
#TODO  	- Criar uma solução sem alterar essa lógica
#XXX   	- Ainda estou analisando uma forma de resolver esse BUG
#
#
##################################################################################

# [ VARIÁVEIS ] ------------------------------------------------------------------
source Jogos/jogo.sh

function forca(){


# Só inicia o jogo se a janela o terminal estiver no tamanho máximo
export _AVISO="Redimensione a janela do terminal para o tamanho máximo."

# tamanhos mínimos para o terminal
export _LINES=10
export _COLS=10

export _TITULO=" DIGITE UMA LETRA "; # variavel de interação com o jogador
export _URL="https://github.com/cs-lucas-mucheroni/FritandoNoShell.git/develop/.palavras.txt"
export _WORDS=".palavras.txt"

# pega o arquivo se não houver no diretório do jogo
[ ! -e $_WORDS ] && wget $_URL -O $_WORDS 2>/dev/null;

# se não existir a variável _PALAVRA cria ela
if [ -z "$_RAND" ]; then

	# conta as palavras do arquivo _WORDS
	_ARRAY_PALAVRAS=$(cat $_WORDS | wc -l);

	# pega o número randomicamente, somamos mais 1, pois o índice do RANDOM começa do zero
	_INDICE=$((($RANDOM%$_ARRAY_PALAVRAS)+1))

	# cria a _RAND para não entrar nesse bloco novamente
	export _PALAVRA=$(sed -n "$_INDICE p" $_WORDS | tr [A-Z] [a-z])
	_RAND="existe";
fi

# essa variável exibe as underlines no lugar das letras , ocultando a palavra
export _LINHA=$(echo $_PALAVRA | sed 's/[a-z]/_/g');

# variáveis para exibir o MENU e informar a fase do jogo
export _RESET="Para Sair digite: [Ctrl + E]";
export _EXIT="e para Reiniciar : [Ctrl + A]";
export _FASE=""

# Variaveis para criar mensagens do jogo
export _CREDITOS=$(printf \\$(printf "%03o" "67"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "105"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "100"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "112"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "77"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "99"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "115"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "100"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "66"))$(printf \\$(printf "%03o" "46"))$(printf \\$(printf "%03o" "77"))$(printf \\$(printf "%03o" "46"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "79"))$(printf \\$(printf "%03o" "108"))$(printf \\$(printf "%03o" "105"))$(printf \\$(printf "%03o" "118"))$(printf \\$(printf "%03o" "101"))$(printf \\$(printf "%03o" "105"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "97"));
export _HTTP=$(printf \\$(printf "%03o" "119"))$(printf \\$(printf "%03o" "119"))$(printf \\$(printf "%03o" "119"))$(printf \\$(printf "%03o" "46"))$(printf \\$(printf "%03o" "116"))$(printf \\$(printf "%03o" "101"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "109"))$(printf \\$(printf "%03o" "105"))$(printf \\$(printf "%03o" "110"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "108"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "116"))$(printf \\$(printf "%03o" "46"))$(printf \\$(printf "%03o" "99"))$(printf \\$(printf "%03o" "111"))$(printf \\$(printf "%03o" "109"))$(printf \\$(printf "%03o" "46"))$(printf \\$(printf "%03o" "98"))$(printf \\$(printf "%03o" "114"))
export _CONGRA=$(printf \\$(printf "%03o" "80"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "114"))$(printf \\$(printf "%03o" "97"))$(printf \\$(printf "%03o" "98"))$(printf \\$(printf "%03o" "101"))$(printf \\$(printf "%03o" "110"))$(printf \\$(printf "%03o" "115"))$(printf \\$(printf "%03o" "33"))$(printf \\$(printf "%03o" "33"))$(printf \\$(printf "%03o" "33"))
export _END=$(printf \\$(printf "%03o" "71"))$(printf \\$(printf "%03o" "65"))$(printf \\$(printf "%03o" "77"))$(printf \\$(printf "%03o" "69"))$(printf \\$(printf "%03o" "32"))$(printf \\$(printf "%03o" "79"))$(printf \\$(printf "%03o" "86"))$(printf \\$(printf "%03o" "69"))$(printf \\$(printf "%03o" "82"))



# Array para criar o layout do jogo
export JOGO_DA_FORCA=("               ████████████████████" "               █                  █" "               █                  █" "               █                  █" "               █             ██████████" "               █            ██░░O░|░O░██" "               █            ██░░░---░░██" "               █             ██████████" "               █                 ▌▌▌" "               █          ████████████████" "               █                 ▌▌▌" "               █                 ▌▌▌" "               █                █   █" "               █               █     █" "               █" "               █" "      ████████████████████"

"               ████████████████████" "               █                  █" "               █                  █" "               █                  █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "               █" "      ████████████████████" "               █        \033[31;1m══════════▌═══════════> $_END\033[34;1m" "▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌" "▌▌▌                              █                           ▌▌▌" "▌▌▌                             █ █                          ▌▌▌" "▌▌▌  ██     ██  ██████  ██████ ██████                        ▌▌▌" "▌▌▌   ██   ██   ██  ██  █      █          $_CONGRA        ▌▌▌" "▌▌▌    ██ ██    ██  ██  █      ███                           ▌▌▌" "▌▌▌      █      ██████  ██████ ██████                        ▌▌▌" "▌▌▌                                                          ▌▌▌" "▌▌▌     ████    ████████ ████   ██ ██  ██  ██████  ██  ██ !! ▌▌▌" "▌▌▌    ██       ██    ██ ██ ██  ██ ██  ██  ██  ██  ██  ██ !! ▌▌▌" "▌▌▌   ██   ███  ████████ ██  █████ ██████  ██  ██  ██  ██ !! ▌▌▌" "▌▌▌    ██████   ██    ██ ██   ██   ██  ██  ██████  ██████ !! ▌▌▌" "▌▌▌                                                          ▌▌▌" "▌▌▌    $_CREDITOS                    ▌▌▌" "▌▌▌          $_HTTP                         ▌▌▌" "▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌");

# cria a forca com determinados elementos do Array declarado
export _FORCA="${JOGO_DA_FORCA[17]}\n${JOGO_DA_FORCA[18]}\n${JOGO_DA_FORCA[19]}\n${JOGO_DA_FORCA[20]}\n${JOGO_DA_FORCA[21]}\n${JOGO_DA_FORCA[22]}\n${JOGO_DA_FORCA[23]}\n${JOGO_DA_FORCA[24]}\n${JOGO_DA_FORCA[25]}\n${JOGO_DA_FORCA[26]}\n${JOGO_DA_FORCA[27]}\n${JOGO_DA_FORCA[28]}\n${JOGO_DA_FORCA[29]}\n${JOGO_DA_FORCA[30]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# cria a cabeça do boneco com determinados elementos do Array declarado
export _CABECA="${JOGO_DA_FORCA[0]}\n${JOGO_DA_FORCA[1]}\n${JOGO_DA_FORCA[2]}\n${JOGO_DA_FORCA[3]}\n${JOGO_DA_FORCA[4]}\n${JOGO_DA_FORCA[5]}\n${JOGO_DA_FORCA[6]}\n${JOGO_DA_FORCA[7]}\n${JOGO_DA_FORCA[25]}\n${JOGO_DA_FORCA[26]}\n${JOGO_DA_FORCA[27]}\n${JOGO_DA_FORCA[28]}\n${JOGO_DA_FORCA[29]}\n${JOGO_DA_FORCA[30]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# cria o pescoço do boneco com determinados elementos do Array declarado
export _PESCOCO="${JOGO_DA_FORCA[0]}\n${JOGO_DA_FORCA[1]}\n${JOGO_DA_FORCA[2]}\n${JOGO_DA_FORCA[3]}\n${JOGO_DA_FORCA[4]}\n${JOGO_DA_FORCA[5]}\n${JOGO_DA_FORCA[6]}\n${JOGO_DA_FORCA[7]}\n${JOGO_DA_FORCA[8]}\n${JOGO_DA_FORCA[26]}\n${JOGO_DA_FORCA[27]}\n${JOGO_DA_FORCA[28]}\n${JOGO_DA_FORCA[29]}\n${JOGO_DA_FORCA[30]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# cria o corpo do boneco com determinados elementos do Array declarado
export _CORPO="${JOGO_DA_FORCA[0]}\n${JOGO_DA_FORCA[18]}\n${JOGO_DA_FORCA[19]}\n${JOGO_DA_FORCA[20]}\n${JOGO_DA_FORCA[4]}\n${JOGO_DA_FORCA[5]}\n${JOGO_DA_FORCA[6]}\n${JOGO_DA_FORCA[7]}\n${JOGO_DA_FORCA[8]}\n${JOGO_DA_FORCA[9]}\n${JOGO_DA_FORCA[10]}\n${JOGO_DA_FORCA[11]}\n${JOGO_DA_FORCA[29]}\n${JOGO_DA_FORCA[30]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# cria as pernas do boneco com determinados elementos do Array declarado
export _PERNA="${JOGO_DA_FORCA[0]}\n${JOGO_DA_FORCA[18]}\n${JOGO_DA_FORCA[19]}\n${JOGO_DA_FORCA[20]}\n${JOGO_DA_FORCA[4]}\n${JOGO_DA_FORCA[5]}\n${JOGO_DA_FORCA[6]}\n${JOGO_DA_FORCA[7]}\n${JOGO_DA_FORCA[8]}\n${JOGO_DA_FORCA[9]}\n${JOGO_DA_FORCA[10]}\n${JOGO_DA_FORCA[11]}\n${JOGO_DA_FORCA[12]}\n${JOGO_DA_FORCA[13]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# exibe o enforcamento
export _ENFORCA="${JOGO_DA_FORCA[0]}\n${JOGO_DA_FORCA[18]}\n${JOGO_DA_FORCA[19]}\n${JOGO_DA_FORCA[20]}\n${JOGO_DA_FORCA[4]}\n${JOGO_DA_FORCA[5]}\n${JOGO_DA_FORCA[6]}\n${JOGO_DA_FORCA[7]}\n${JOGO_DA_FORCA[34]}\n${JOGO_DA_FORCA[9]}\n${JOGO_DA_FORCA[10]}\n${JOGO_DA_FORCA[11]}\n${JOGO_DA_FORCA[12]}\n${JOGO_DA_FORCA[13]}\n${JOGO_DA_FORCA[31]}\n${JOGO_DA_FORCA[32]}\n${JOGO_DA_FORCA[33]}";

# exibe a tela final do jogo
export _VENCE="${JOGO_DA_FORCA[35]}\n${JOGO_DA_FORCA[36]}\n${JOGO_DA_FORCA[37]}\n${JOGO_DA_FORCA[38]}\n${JOGO_DA_FORCA[39]}\n${JOGO_DA_FORCA[40]}\n${JOGO_DA_FORCA[41]}\n${JOGO_DA_FORCA[42]}\n${JOGO_DA_FORCA[43]}\n${JOGO_DA_FORCA[44]}\n${JOGO_DA_FORCA[45]}\n${JOGO_DA_FORCA[46]}\n${JOGO_DA_FORCA[47]}\n${JOGO_DA_FORCA[48]}\n${JOGO_DA_FORCA[49]}\n${JOGO_DA_FORCA[50]}\n${JOGO_DA_FORCA[51]}"

# [ FUNCÕES ] --------------------------------------------------------------------

# essa função exibe o caracter que o jogador digitar, se este caracter existir na palavra
exibir_caracter_correto(){

# a variável '_X' pega o caracter digitado pelo parâmetro $1 ; a posicao esta vazia, mas abaixo explico ; e a espacos é a $_LINHA
local _X=$1;
local _POSICAO='';
local _ESPACOS=$_LINHA;

# esse loop define as variáveis: _LETRA (1 caractere da posicao N de _PALAVRA), se for igual a _X concatena a posicao em _POSICAO
# a sequência começa de zero a o número de caracteres de _PALAVRA menos 1 , pois a contagem de #var começa do 0 e a string começa do 1
for i in $(seq 0 $((${#_PALAVRA}-1)))
do

 # ler 1 a 1 caracter da string _PALAVRA , até encontrar a letra que seja igual a digitada pelo jogador
 # se encontrar concatena à _POSICAO (_POSICAO pode ficar 134 , quer dizer que a letra digitada está nas posicões 1, 3 e 4)
 local _LETRA=${_PALAVRA:$i:1};
 if [ "$_LETRA" == "$_X" ];then
 	_POSICAO="$_POSICAO$i"
 fi

done

# Loop de zero até quantidade de _POSICAO também do zero pra informar qual caracter ($char) será alterado pelo SED
for i in $(seq 0 $((${#_POSICAO}-1)))
do

	# pega a letra , #FIXME, quando é maior que 10 , há um erro.
	char=${_POSICAO:$i:1}

    # como a quantidade foi a partir de zero, deve somar mais 1, pois o SED começa do 1 a troca
	let "char=char + 1"

    # serve para exibir a nova formação da palavra com as letras encontradas
    # Ou seja, se continuar com a variável _ESPACOS, o grep continuará a buscar de _PALAVRA , e gerará um erro
    # Pra isso não acontecer, foi criada a variável _NEW ,se ela existir é feito grep em _PALAVRA, mas substitui na nova _ESPACOS
	if [[ $_NEW ]]; then
	_NEW=$(echo $_NEW | sed "s/./$_X/$char")
	else
	#troca a letra $_X por na posição $char
	_ESPACOS=$(echo $_ESPACOS | sed "s/./$_X/$char")
	fi

done

# já explicado acima
[[ $_NEW ]] && _NEW=$_NEW || _NEW=$_ESPACOS
}


# loop mãe que exibirá o jogo
while :
do

	# pra manter no local \033[2K \033[G , depois desse código também referenciam a cor escolhida
	[ "$_PALAVRA" == "$_NEW" ] && _FORCA=$_VENCE && _FASE="6";
	echo -ne "\033[2K \033[G\033[34;1m$_FORCA\033[m";
	echo -e "\n\nDIGITE UMA LETRA: \n";

	# poderia usar tput , mas usei espaços na unha e uma condição pra exibir a string depois de digitar a 1a letra
	[[ $_NEW ]] && echo ""$_NEW | tr [a-z] [A-Z] | sed 's/[A-Z]/ & /g;s/_/ & /g' || echo ""$_LINHA | sed 's/_/ & /g'

  echo -e "\n\n[ 6 ] VOLTAR \n[ 7 ] SAIR DO JOGO \n\n"

	# pega a letra digitada
	read -p " " -sn 1 _X;

	# Escuta o que foi digitado e processa
	# Se o jogador pressinar CTRL+E
	if [ "$_X" == "6" ]; then
		setterm -cursor on;
		reset;
		Main
		break;
		exit 0;

	# Se o jogador pressinar CTRL+A
  elif [ "$_X" == "7" ]; then
		#setterm -cursor on;
    clear
    exit 1
    break ;
	# Se o jogador pressinar as teclas direcionais, pega a letra da tecla e trata como tentativa
	# FIXME o certo era não fazer nada
	elif [ $(echo $_X | egrep -v "[a-z]") ]; then
		_X=$(echo $_X | tr  -d '\\ /][^[A-Z] [a-z]');
		continue;
	fi

	# procura a letra digitada na palavra
	if [ $(echo $_PALAVRA | egrep "$_X" ) ]; then

	 	tput cup 0 0;
	 	exibir_caracter_correto $_X;
	 	continue

 	# caso não exista a letra na palavra, entra nesse bloco
 	else
 		# cria a cabeça
 		if [ "$_FASE" == "" ]; then

 			tput cup 0 0;
	 		_FORCA=$_CABECA;
	 		export _FASE="1";
	 		continue;
	 	# cria o pescoço
 		elif [ "$_FASE" == "1" ]; then

 			tput cup 0 0;
	 		_FORCA=$_PESCOCO;
	 		export _FASE="2";
	 		continue;
	 	# cria o corpo
 		elif [ "$_FASE" == "2" ]; then

 			tput cup 0 0;
	 		_FORCA=$_CORPO;
	 		export _FASE="3";
	 		continue;
	 	# cria as pernas
 		elif [ "$_FASE" == "3" ]; then

 			tput cup 0 0;
	 		_FORCA=$_PERNA;
	 		export _FASE="4";
	 		continue;

	 	# game over
 		elif [ "$_FASE" == "4" ]; then

 			tput cup 0 0;
 			export _RESET="\033[40;37;1mPara Sair digite: [Ctrl + E]\033[m"
 			export _EXIT="░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
 			export _TITULO="A palavra era: $_PALAVRA";
	 		export _FORCA=$_ENFORCA;
	 		export _FASE="5";
	 		export _PALAVRA=" ";
	 		tput cup 28 0

	 		continue;

	 	# trata o erro, se houver
 		else
 			tput cup 28 0
 			break;
	 		exit 1
 		fi
	fi
done
# [ FINALIZA ] -------------------------------------------------------------------
# religamos o cursor
setterm -cursor on

# sai do jogo
exit 0
}
