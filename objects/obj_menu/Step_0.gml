// --- 1. ler o inputs do teclado ---
var _key_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed("S");

var _key_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed("W");

// --- 2. mover seleção ---

//se apertou pra baixo
if (_key_down)
{
	//aumenta o indice da seleção
	op_selecionada ++;
	
	//se passar da ultima opção volta pra primeira
	if(op_selecionada >= op_total)
	{
		op_selecionada = 0;
	}
}

//se apertou pra cima
if(_key_up)
{
	//diminui o indice da seleção
	op_selecionada --;
	
	//se passar da primeira opção vai pra ultima
	if(op_selecionada < 0)
	{
		op_selecionada = op_total - 1;
	}
}

// --- 3. executar ação (enter) ---

//detecta se a techa enter foi pressionada
var _key_enter = keyboard_check_pressed(vk_enter);

if(_key_enter)
{
	//executa uma ação baseada na opção selecionada
	switch (op_selecionada)
	{
		//caso 0: "iniciar"
		case 0:
			room_goto(rm_jogo_inicial);
			break;
			
		//caso 1: "fechar"	
		case 1:
			game_end(); //fecha o jogo
			break;
			
	}
}