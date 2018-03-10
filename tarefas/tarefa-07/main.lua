larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()
--  ================ DEFINIÇÃO DE CONSTANTES ================


-- tarefa - 07 --> resumo
-- Para a tarefa foi considerado a analise do objeto inimigo no codigo
-- Cada inimigo ao ser criado é alocado no array Inimigos

  -- escopo: o tempo de vida do objeto e as acoes do inimigo ocorre no escopo da funcao "atualizarInimigos" (linha 173)
  -- alocacao: dentro da função "criarNovoInimigo" (linha 128) que esta no escopo da funcao "atualizarInimigos" (linha 173)
  -- desalocacao: dentro da funcão "atualizarInimigos" (linha 173)
  -- colisao: realizada a verificacao no escopo da funcao "Tiro Acertou" (linha 240) que se encontra dentro do escopo da funcao "atualizarTiros" (linha 250)


constante_larguraBarras = 15 -- pixels
constante_multiplicadoraBarras = 2.5 -- para deixar as barras do jogo mais extensas (vida e municao)

constante_qtdMaximaDeTirosCanhoes = 30
-- tarefa-05
-- Nome: constante_qtdMaximaDeTirosCanhoes
-- Propriedade: valor
-- Binding time: tempo de compilação
-- Explicacao: por se tratar de uma variável global o seu valor é definido no código e 
--				amarrado em tempo de compilação

constante_intervaloDeDisparoCanhoes = 0.5 -- segundos
constante_intervaloDeAtualizacaoDoCursor = 0.2 -- segundos
constante_intervaloDeAparicaoDeInimigos = 10 -- segundos
constante_vidaInimigoAzulTam1 = 25 -- em qtd de acertos
constante_velocidadeInimigoAzulTam1 = 40 -- em pixels*dt

-- posicao inicial dos inimigos
--   eles começam no canto esquerdo na metade da altura do caminho
constante_xInicialInimigo = 0

-- tarefa-05
-- Nome: constante_xInicialInimigo
-- Propriedade: endereço
-- Binding time: tempo de compilação
-- Explicacao: por ser uma variável global seu endereço é amarrado em tempo de compilação 
				

constante_yInicialInimigo = 142 -- media do ponto y da parte de cima e da de baixo do inicio do caminho


-- aqui temos os demais vertices do caminho (valores medidos usando o mouse no jogo)
--   a ideia aqui é fazer de forma generica o deslocamento baseado num mapeamento de pixels
--      cada estado representa uma parte do caminho dividido pelas curvas que existem nele
--   o multiplicador nas tables abaixo é para indicar se deve subir ou descer no percurso

-- tarefa - 06 	--> Tipo de dado TUPLA nas variaveis "baixo" e "cima", pois essas variaveis são coordenadas.
constante_limiteCaminhoEstado1 = {baixo = { 175, 180}, cima = { 265, 95} , multiplicadorDeDirecaoDoEstado = 1} -- vertices da primeira reta
constante_limiteCaminhoEstado2 = {baixo = { 175, 450}, cima = { 265, 360}, multiplicadorDeDirecaoDoEstado = 1 } -- vertices da segunda reta
constante_limiteCaminhoEstado3 = {baixo = { 635, 450}, cima = { 540, 360}, multiplicadorDeDirecaoDoEstado = 1 } -- vertices da terceira reta
constante_limiteCaminhoEstado4 = {baixo = { 635, 190}, cima = { 540, 100}, multiplicadorDeDirecaoDoEstado = -1 } -- vertices da quarta reta
constante_limiteCaminhoEstado5 = {baixo = { 810, 190}, cima = { 810, 100}, multiplicadorDeDirecaoDoEstado = 1 } -- vertices do fim do caminho

-- colocando numa nova table agrupado, é possível acessar as informações necessárias pelo estado do caminho em que esta
constantes_limiteCaminhoEstados = { constante_limiteCaminhoEstado1, constante_limiteCaminhoEstado2,
									constante_limiteCaminhoEstado3, constante_limiteCaminhoEstado4,
									constante_limiteCaminhoEstado5
									}						
				
									
-- ========================= FIM DEFINIÇÕES =========================

function love.load()
-- tarefa-05
-- Nome: function
-- Propriedade: semantica
-- Binding time: design da linguagem
-- Explicacao: "function" é uma palavra reservada da linguagem, que detemina a inicio
--				de uma função, portanto definido no design da linguagem

 imgBackground = love.graphics.newImage("plano-de-fundo.png")
 
 imgCanhaoCinza = love.graphics.newImage("tanque-cinza.png")
 imgTiro = love.graphics.newImage("tiro.png")
 
 imgCursorBase = love.graphics.newImage("cursor-base.png")
 imgCursorSelecionado = love.graphics.newImage("cursor-selecionado.png")
 
 imgInimigoAzulTam1 = love.graphics.newImage("inimigo-azul-tam1.png")
 
 carregarJogo()
 
 love.mouse.setVisible(false)
end

-- carrega o inicio do jogo (separado aqui para permitir reload com a tecla ENTER)
function carregarJogo()
	-- cursor que seleciona os quadrados para instalar canhões
	cursor = {
		x = 0,
		y = 0,
		imagem = imgCursorBase, -- cursor amarelo, apenas para seleção é a imagem padrão, a que deve começar
		maxX = imgBackground:getWidth(), -- limite x do campo, facilita calculos depois
		maxY = imgBackground:getHeight(), -- o mesmo de cima
		canhaoAtual ={  -- canhao padrão que vai ser girado enquanto se esta no modo selecao
						x = 0,
						y = 0,
						rotacao = 0,
						qtdMaximaDeTiros = constante_qtdMaximaDeTirosCanhoes,
						imagem = imgCanhaoCinza
					},
		perdeu = false
	}
	tempoCriacaoInimigos = constante_intervaloDeAparicaoDeInimigos -- constante carregada aqui para que qnd se reinicie o jogo já nasca inimigo
	
	-- tarefa - 06 	--> Tipo de dado ARRAY nas variaveis "canhoes" e "tiros". Guarda as variaveis registros "novoCanhao" e "novoTiro", essas variaveis 
					-- são incluidas e retiradas dos arrays em ordem numerica, ou seja o primeiro objeto a ser incluido é o primeiro a ser retirado (ideia de fila)
					-- os elementos sao identificados pela posicao dentro do array (durante a execucao do codigo).
	canhoes = {} -- armazena tds os canhoes ativos
	tiros = {} -- armazena todos os tiros ativos
	
	-- tarefa - 06 	--> Tipo de dado LISTA na variavel "inimigos". 
		--	Essas variaveis guardam os  e novoInimigo, que sao retirados fora de ordem dessas listas
	inimigos = {} -- armazena todos os inimigos ativos
	
	
	
	
end

-- ===================== CONTROLES DOS INIMIGOS =============================

function criarNovoInimigo()

-- tarefa - 06 	--> Tipo de dado REGISTRO na variavel "novoInimigo". Apresenta conjunto de valores homogeneos, no qual os elementos são 
				 --identificados pelo nome 
				 
-- tarefa - 07 	-->  Criação da estrutura do objeto inimigo
	novoInimigo = {
		x = constante_xInicialInimigo,
		y = constante_yInicialInimigo,
		estadoCaminho = 1,
		vida = constante_vidaInimigoAzulTam1,
		velocidade = constante_velocidadeInimigoAzulTam1,
		imagem = imgInimigoAzulTam1
	}
	table.insert(inimigos, novoInimigo)
end

-- funcao que movimenta os inimigos
--   as retas de numeracao impar são as retas onde se deve incrementar x
--   as retas de numeracao par são as retas onde se deve incrementar y
-- aqui se aplica o multiplicadorDeDirecaoDoEstado
--   ele é resposnavel por dizer se deve somar ou subtrair (seu valor é +1 ou -1)
-- vale ressaltar que se for pra subtrair, é preciso lembrar que o valor atual deve diminuir, então a verificação de atual < final não atenderia
-- ao chegar ao fim do percurso incrementa seu estado
function caminharInimigo(inimigo, dt)
	multiplicadorDeDirecao = constantes_limiteCaminhoEstados[inimigo.estadoCaminho].multiplicadorDeDirecaoDoEstado
	if inimigo.estadoCaminho % 2 == 0 then
		posicaoFinal = (constantes_limiteCaminhoEstados[inimigo.estadoCaminho].baixo[2] + constantes_limiteCaminhoEstados[inimigo.estadoCaminho].cima[2]) / 2
		if ( (multiplicadorDeDirecao > 0) and (inimigo.y < posicaoFinal) ) or ( (multiplicadorDeDirecao < 0) and (inimigo.y > posicaoFinal) )then
			inimigo.y = inimigo.y + multiplicadorDeDirecao*inimigo.velocidade * dt
		else
			inimigo.estadoCaminho = inimigo.estadoCaminho + 1
		end
	else
		posicaoFinal = (constantes_limiteCaminhoEstados[inimigo.estadoCaminho].baixo[1] + constantes_limiteCaminhoEstados[inimigo.estadoCaminho].cima[1]) / 2
		if ( (multiplicadorDeDirecao > 0) and (inimigo.x < posicaoFinal) ) or ( (multiplicadorDeDirecao < 0) and (inimigo.x > posicaoFinal) )then
			inimigo.x = inimigo.x + multiplicadorDeDirecao * inimigo.velocidade * dt
		else
			inimigo.estadoCaminho = inimigo.estadoCaminho + 1
		end
	end
end

-- aonde o tempo para criar novos inimigos é utilizado
-- também responsavel por verificar: se chegou algum inimigo ao final, movimenta-lo ou remove-lo apos a morte
function atualizarInimigos(dt)
	tempoCriacaoInimigos = tempoCriacaoInimigos + dt
	if tempoCriacaoInimigos >= constante_intervaloDeAparicaoDeInimigos then
		tempoCriacaoInimigos = 0
		-- tarefa - 07 	--> alocacao do inimigo: criação do inimigo 
		criarNovoInimigo() 
	end
	
	for index = table.getn(inimigos), 1, -1 do
		inimigo = inimigos[index]
		if inimigo.vida <= 0 or inimigo.estadoCaminho == 6 then
			if inimigo.estadoCaminho == 6 then --pq o quantidade de estados sao 5
				cursor.perdeu = true
			end
			-- tarefa - 07 	--> desalocacao de inimigo: tempo de vida de inimigo acaba abaixo
			table.remove(inimigos, index) 
		else
			caminharInimigo(inimigo, dt)
		end
	end
	
end

-- ===================== COLISÃO INIMIGO x TIRO ==========================
-- funcao de colisão (só utilizada com tiro e inimigo)
-- aqui se considera a prespectiva horizontal primeiro (tiros vindo da direita ou da esquerda)
-- depois se considera a perspectiva vertical (tiros vindo de cima ou de baixo)
function checaColisoes(obj1, obj2)
	w1 = obj1.imagem:getWidth()
	h1 = obj1.imagem:getHeight()
	w2 = obj2.imagem:getWidth()
	h2 = obj2.imagem:getHeight()
	-- primeiro considerando da perspectiva horizontal
	return ( obj1.x - w1/2 <= obj2.x + w2/2 and obj1.x + w1/2 >= obj2.x - w2/2 and obj2.y >= obj1.y - h1 / 2 and obj2.y <= obj1.y + h1/2) or
			-- depois da perspectiva vertical
			( obj1.y - h1/2 <= obj2.y + h2/2 and obj1.y + h1/2 >= obj2.y - h2/2 and obj2.x >= obj1.x - w1/2 and obj2.x <= obj1.x + w1/2)
end

-- ===================== CONTROLES DOS TIROS =============================
function atirar(xInicialTiro, yInicialTiro, rotacaoTiro)
	novoTiro = {
					x = xInicialTiro,
					y = yInicialTiro,
					rotacao = rotacaoTiro,
					imagem = imgTiro
				}
	table.insert(tiros, novoTiro)
end

-- verifica se o tiro saiu da tela em uma das extremidades dependendo da direção em que esta rotacionado
function tiroForaDaTela(tiro)
	if tiro.rotacao == 0 then -- direita
		return tiro.x + imgTiro:getWidth() >= imgBackground:getWidth()
	end
	if tiro.rotacao == -math.pi/2 then -- pra cima
		return tiro.y <= 0
	end
	if tiro.rotacao == -math.pi then -- pra esquerda
		return tiro.x <= 0
	end
	if tiro.rotacao == -math.pi*1.5 then -- para baixo  (pi*(3/2))
		return tiro.y + imgTiro:getHeight() >= imgBackground:getHeight()
	end
end

-- checando remoção do tiro por acerto 
-- e fazendo logo a colisão com o inimigo e decrescendo a vida
function tiroAcertou(tiro) -- tarefa - 07 	--> verifica se o tiro acertou o inimigo (colisão)
	for index, inimigo in ipairs(inimigos) do
		if checaColisoes(inimigo, tiro) then
			inimigo.vida = inimigo.vida - 1
			return true
		end
	end
end

-- movimentacao dos tiros
function atualizarTiros(dt)
	for index = table.getn(tiros), 1, -1 do
		tiro = tiros[index]
		if tiroForaDaTela(tiro) or tiroAcertou(tiro) then -- só atualiza se o tiro ainda pode ficar na tela
			table.remove(tiros, index)
		else
			if tiro.rotacao == 0 then -- direita
				tiro.x = tiro.x + 200*dt
			-- tarefa-05
			-- Nome: tiro.x
			-- Propriedade: valor
			-- Binding time: tempo de execução
			-- Explicacao: o valor da variável "tiro.x" é frequentemente alterado e só sabemos
			--				eu valor em tempo de execução
			end
			if tiro.rotacao == -math.pi/2 then -- cima
				tiro.y = tiro.y - 200*dt
			end
			if tiro.rotacao == -math.pi then -- esquerda
				tiro.x = tiro.x - 200*dt
			end
			if tiro.rotacao == -math.pi*1.5 then -- baixo  (pi*(3/2))
				tiro.y = tiro.y + 200*dt
			end			
		end
	end
end

-- ==================== CONTROLE DOS CANHOES ==============================

-- instalar canhao seria colocar de fato o canhao que esta sendo pre-visualizado no cursor
function instalarCanhao(canhao)
	novoCanhao = {
					x = canhao.x,
					y = canhao.y,
					rotacao = canhao.rotacao,
					qtdMaximaDeTiros = constante_qtdMaximaDeTirosCanhoes,
					imagem = canhao.imagem
				}	
			-- tarefa-05
			-- Nome: novoCanhao.imagem
			-- Propriedade: endereço
			-- Binding time: tempo de execução
			-- Explicacao: o endereço da variável é determinado apenas quando um canhão 
			--				é colocado na tela, logo seu endereço é apenas conhecido
			--				em tempo de execução
				
	table.insert(canhoes, novoCanhao)
end

-- reinicia o canhao que esta associado ao cursor
function reiniciarCanhao(canhao)
	canhao.x = cursor.x + cursor.imagem:getWidth() / 2 -- lembrando que o ponto do objeto do canhao esta no centro e não no canto superior esquerdo
	canhao.y = cursor.y + cursor.imagem:getHeight() / 2
	canhao.rotacao = 0
end

tempoAttCanhoes = 0

function atualizarCanhoes(dt) -- identificar de quanto em quanto tempo o canhão pode atirar
	tempoAttCanhoes = tempoAttCanhoes + dt
	if tempoAttCanhoes >= constante_intervaloDeDisparoCanhoes then
		for index = table.getn(canhoes), 1, -1 do
			if canhoes[index].qtdMaximaDeTiros - 1 < 0 then
				table.remove(canhoes, index)
			else
				dispara(canhoes[index])
				tempoAttCanhoes = 0
			end
		end
	end

end

-- seleciona a posicao inicial do tiro dependendo da direcao em que o canhao esta virado
function ajustarPosicaoDoTiroQuandoCanhaoRotacionado(canhao)
	parametrosPosicaoTiro = {
		xInicialTiro = 0,
		yInicialTiro = 0
	}
	
	if canhao.rotacao == 0 then -- direita
		parametrosPosicaoTiro.xInicialTiro = canhao.x + canhao.imagem:getWidth()/2 -- de novo, o ponto do canhao é no centro do objeto
		parametrosPosicaoTiro.yInicialTiro = canhao.y
	end
	if canhao.rotacao == -math.pi/2 then -- cima
		parametrosPosicaoTiro.xInicialTiro = canhao.x
		parametrosPosicaoTiro.yInicialTiro = canhao.y - canhao.imagem:getWidth()/2
	end
	if canhao.rotacao == -math.pi then -- esquerda
		parametrosPosicaoTiro.xInicialTiro = canhao.x - canhao.imagem:getWidth()/2
		parametrosPosicaoTiro.yInicialTiro = canhao.y
	end
	if canhao.rotacao == -math.pi*1.5 then -- baixo
		parametrosPosicaoTiro.xInicialTiro = canhao.x
		parametrosPosicaoTiro.yInicialTiro = canhao.y + canhao.imagem:getWidth()/2
	end
	
	return parametrosPosicaoTiro
	
end

-- define a posicao do tiro e cria o novo tiro
function dispara(canhao)
	posicaoTiro = ajustarPosicaoDoTiroQuandoCanhaoRotacionado(canhao)
	atirar(posicaoTiro.xInicialTiro, posicaoTiro.yInicialTiro, canhao.rotacao)
	
	canhao.qtdMaximaDeTiros = canhao.qtdMaximaDeTiros - 1
end
-- ============================ CONTROLE DO CURSOR ===========================================

tempoAttCursor = 0
function controleCursor(dt)
	tempoAttCursor = tempoAttCursor + dt
	if tempoAttCursor >= constante_intervaloDeAtualizacaoDoCursor then

	-- tarefa - 06 --> Tipo de dado ENUMERACAO na variavel "keyboard" da própria linguagem. 
					-- A identificacao das teclas do teclado é feita por valores literais	
		if love.keyboard.isDown("up") and cursor.imagem == imgCursorBase then
			tempoAttCursor = 0
			deltay = cursor.y - cursor.imagem:getHeight()
			if deltay >= 0 then 
				cursor.y = deltay
			end
		end
		if love.keyboard.isDown("down") and cursor.imagem == imgCursorBase then
			tempoAttCursor = 0
			deltay = cursor.y + cursor.imagem:getHeight()
			if deltay + cursor.imagem:getHeight() <= cursor.maxY then 
				cursor.y = deltay
			end
		end
		if love.keyboard.isDown("left") and cursor.imagem == imgCursorBase then
			tempoAttCursor = 0
			deltax = cursor.x - cursor.imagem:getWidth()
			if deltax >= 0 then
				cursor.x = deltax
			end
		end
		if love.keyboard.isDown("right") and cursor.imagem == imgCursorBase then
			tempoAttCursor = 0
			deltax = cursor.x + cursor.imagem:getWidth()
			if deltax + cursor.imagem:getWidth() <= cursor.maxX then
				cursor.x = deltax
			end
		end
		if love.keyboard.isDown("x") and cursor.imagem == imgCursorSelecionado then
			tempoAttCursor = 0
			cursor.canhaoAtual.rotacao = cursor.canhaoAtual.rotacao - math.pi/2
			if cursor.canhaoAtual.rotacao == -math.pi*2 then
				cursor.canhaoAtual.rotacao = 0
			end
		end
		-- se ja criado, faz a instalação de um novo canhão
		if love.keyboard.isDown("z") and cursor.imagem == imgCursorSelecionado then
			tempoAttCursor = 0
			instalarCanhao(cursor.canhaoAtual)
			cursor.imagem = imgCursorBase
		end
		
		-- cria um novo canhao e pode cancelar a instalação
		if love.keyboard.isDown("space") then
			tempoAttCursor = 0
			if cursor.imagem == imgCursorSelecionado then
				cursor.imagem = imgCursorBase
			else
				cursor.imagem = imgCursorSelecionado
				reiniciarCanhao(cursor.canhaoAtual)
			end
		end
	end

end

-- tarefa-05
	-- Nome: not
	-- Propriedade: semantica
	-- Binding time: design da linguagem
	-- Explicacao: palavra reservada da linguagem que indica negação, portanto sua definição e 
	--				funcionalidade são determinados pela linguagem
function controleGeral(dt)
	if not cursor.perdeu then
		controleCursor(dt)
		atualizarCanhoes(dt)
		atualizarTiros(dt)
		atualizarInimigos(dt)
	end
	
	if love.keyboard.isDown("return") then  -- qdo usar a tecla enter
		carregarJogo()
	end
end

function drawInimigoVida(inimigo)
	r,g,b = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.setLineWidth(constante_larguraBarras) --a altura da barra de vida
	
	acimaDaCabeca = inimigo.y - inimigo.imagem:getHeight()*0.7  --posicao y da barra de vida do inimigo (acima dele)
	
	pontoDeInicioBarra = inimigo.x - (constante_vidaInimigoAzulTam1*constante_multiplicadoraBarras)*1/2  --posicao x da barra de vida do inimigo (acima dele)
	
	love.graphics.line(pontoDeInicioBarra, acimaDaCabeca, pontoDeInicioBarra + constante_vidaInimigoAzulTam1*constante_multiplicadoraBarras, acimaDaCabeca)
	love.graphics.setColor(0, 255, 0)
	love.graphics.line(pontoDeInicioBarra, acimaDaCabeca, pontoDeInicioBarra + inimigo.vida*constante_multiplicadoraBarras, acimaDaCabeca)
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(inimigo.vida, inimigo.x - 5, acimaDaCabeca - 5, 0, 1, 1)
	
	love.graphics.setColor(r, g, b)
end

function drawMunicaoCanhao(canhao)
	pontoDeInicio = {
		x = 0,
		y = 0
	}
	pontoDeFimValor = { -- ponto da barra que se move
		x = 0,
		y = 0
	}
	pontoDeFimBase = { --ponto da barra fixa
		x = 0,
		y = 0
	}
	if canhao.rotacao % math.pi == 0 then
		pontoDeInicio.x = canhao.x-5 - (constante_qtdMaximaDeTirosCanhoes*(constante_multiplicadoraBarras+0.5))/2
		pontoDeInicio.y = canhao.y - canhao.imagem:getHeight()*0.75
		
		pontoDeFimBase.x = pontoDeInicio.x + (constante_qtdMaximaDeTirosCanhoes*(constante_multiplicadoraBarras+0.5))
		pontoDeFimBase.y = pontoDeInicio.y
		
		pontoDeFimValor.x = pontoDeInicio.x + (canhao.qtdMaximaDeTiros*(constante_multiplicadoraBarras+0.5))
		pontoDeFimValor.y = pontoDeInicio.y
	else
		pontoDeInicio.x = canhao.x - canhao.imagem:getHeight()*0.75
		pontoDeInicio.y = canhao.y+5 + (constante_qtdMaximaDeTirosCanhoes*(constante_multiplicadoraBarras+0.5))/2
		
		pontoDeFimBase.x = pontoDeInicio.x
		pontoDeFimBase.y = pontoDeInicio.y - (constante_qtdMaximaDeTirosCanhoes*(constante_multiplicadoraBarras+0.5))

		pontoDeFimValor.x = pontoDeInicio.x 
		pontoDeFimValor.y = pontoDeInicio.y - (canhao.qtdMaximaDeTiros*(constante_multiplicadoraBarras+0.5))
	end
	
	--desenhando a barra de tiros do canhao
	love.graphics.setLineWidth(constante_larguraBarras)
	
	r, g, b = love.graphics.getColor()
	love.graphics.setColor(105, 105, 105)
	
	love.graphics.line(pontoDeInicio.x, pontoDeInicio.y, pontoDeFimBase.x, pontoDeFimBase.y)
	love.graphics.setColor(255, 255, 0)
	love.graphics.line(pontoDeInicio.x, pontoDeInicio.y, pontoDeFimValor.x, pontoDeFimValor.y)
	
	love.graphics.setColor(0, 0, 255)
	love.graphics.print(canhao.qtdMaximaDeTiros, (pontoDeInicio.x + pontoDeFimBase.x)/2 -5,(pontoDeInicio.y + pontoDeFimBase.y)/2 - 5, 0, 1, 1)
	
	love.graphics.setColor(r, g, b)
	
end

function love.draw()
	love.graphics.setBackgroundColor(0, 0, 0)
	
	love.graphics.draw(imgBackground, 0, 0, 0, 1, 1, 0, 0 )
	
	love.graphics.draw(cursor.imagem, cursor.x, cursor.y, 0)
	
	for index, canhao in ipairs(canhoes) do
		love.graphics.draw(canhao.imagem, canhao.x, canhao.y, canhao.rotacao, 1, 1, canhao.imagem:getWidth()/2, canhao.imagem:getHeight()/2)
		drawMunicaoCanhao(canhao)
	end
	
	if cursor.imagem == imgCursorSelecionado then
		love.graphics.draw(cursor.canhaoAtual.imagem, cursor.canhaoAtual.x, cursor.canhaoAtual.y, cursor.canhaoAtual.rotacao, 1, 1, cursor.canhaoAtual.imagem:getWidth()/2, cursor.canhaoAtual.imagem:getHeight()/2)
	end

	for index, tiro in ipairs(tiros) do
		love.graphics.draw(imgTiro, tiro.x, tiro.y, tiro.rotacao, 1, 1)
	end
	
	for index, inimigo in ipairs(inimigos) do
		love.graphics.draw(inimigo.imagem, inimigo.x, inimigo.y , 0, 1, 1, inimigo.imagem:getWidth()/2, inimigo.imagem:getHeight()/2)
		drawInimigoVida(inimigo)
	end
	if cursor.perdeu then
		r, g, b = love.graphics.getColor()
		love.graphics.setColor(0, 0, 0)
		love.graphics.print("você perdeu! aperte ENTER para reiniciar.", imgBackground:getWidth()*0.2, imgBackground:getHeight()/2, 0, 2, 2)
		love.graphics.setColor(r, g, b)
	end
end

function love.update(dt)
	controleGeral(dt)
end