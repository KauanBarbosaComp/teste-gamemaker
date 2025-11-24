var outro = instance_place(x, y, obj_entidade);

//se eu estou tocando em alguem
if(outro)
{
	//dando mensagem
	show_debug_message("foi!!!!" + string(id));
	//se eu nao estou tocando no meu pai
	if(outro.id != pai)
	{
		
		//checando quem é pai do outro
		var papi = object_get_parent(outro.object_index);
		if(papi != object_get_parent(pai.object_index))
		{
			
			if(outro.vida_atual > 0)
			{
			outro.estado = "hit";
			outro.image_index = 0;
			outro.vida_atual -= dano;
			instance_destroy();
			}
		}
	}
}