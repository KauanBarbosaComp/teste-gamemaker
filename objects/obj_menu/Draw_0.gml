//configura como o textoserá desenhado
//drawn_set_font(fnt_menu); //crie uma fonte chamadafnt_menu
draw_set_valign(fa_middle); //alinha verticalmente pra o meio
draw_set_halign(fa_center); //alinha horizontalmente pra o centro

//pega o centro da room
var _x = room_width / 2;
var _y = room_height / 2;

//loop pra desenhar as opções
for(var i = 0; i < op_total; i++)
{
	//texto da opção atual
	var _texto = opcoes[i];
	//cor da opção
	var _cor = c_white; //cor padrão (branco)
	
	// 1. decide qual cor usar
	if(i == op_selecionada)
	{
		_cor = c_yellow; //selecionada = amarelo
	}
	else
	{
		_cor = c_white; //não selecionada = branco
	}
	
	// 2. define a cor que o gamemaker usará
	draw_set_color(_cor);
	
	// 3. desenha o texto da opção
	draw_text(_x, _y + (i * 50), _texto);
	
	// 4. desenha o ponteiro
	if(i == op_selecionada)
	{
		draw_text(_x - 100, _y + (i * 50), ">");
	}
}