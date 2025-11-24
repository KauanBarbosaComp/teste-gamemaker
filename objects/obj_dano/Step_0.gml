var outro = instance_place(x, y, obj_entidade);
var outro_lista = ds_list_create();
var quantidade = instance_place_list(x, y, obj_entidade, outro_lista, 0);

//adicionando todo mundo que toquei na lista de aplicar dano
for( var i = 0; i < quantidade; i++)
{
	//checando o atual
	var atual = outro_lista[|i];
	
	//show_message(object_get_name(atual.object_index));
	//checando se a colisão não é com um filho do meu pai
	if(object_get_parent(atual.object_index) != object_get_parent(pai.object_index))
	{
		//show_message("posso dar dano");
		//checando se realmente posso dar dano
		
		//checar se o atual já está na lista
		var pos = ds_list_find_index(aplicar_dano, atual);
		if( pos == -1)
		{
			//o atual ainda não está na lista de dano
			//adiciona o atual na lista de dano
			ds_list_add(aplicar_dano, atual);
		}
	}
}

//aplicando o dano
var tam = ds_list_size(aplicar_dano);
for(var i = 0; i < tam; i++)
{
	outro = aplicar_dano[|i].id;
	if(outro.vida_atual > 0)
	{
		outro.estado = "hit";
		outro.image_index = 0;
		outro.vida_atual -= dano;
	}
}

//destruindo a lista
ds_list_destroy(aplicar_dano);
ds_list_destroy(outro_lista);

instance_destroy();

/*/se eu estou tocando em alguem
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
}*/