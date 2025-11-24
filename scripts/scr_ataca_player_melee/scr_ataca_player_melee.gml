// Define a função com o nome do script e seus argumentos
function scr_ataca_player_melee(outro, dist, xscale) {
	
	// Os comentários ///@arg não são mais necessários
	// E você não precisa mais usar argument0, argument1, etc.
	// Os nomes (outro, dist, xscale) já são as variáveis.

	//checando se o player está na linha de visao
	var player = collision_line(x, y - sprite_height/2, x + (dist * xscale), y - sprite_height/2, outro, 0, 1);

	//se o player entrou na linha de visão
	if (player) // 'player' aqui é o id da instância que colidiu, ou noone
	{
		estado = "attack";
	}
}