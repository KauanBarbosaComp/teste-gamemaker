// gravidadde 0 para ele não cair
velh = 0;

//maquina de estados
switch(estado)
{
	case "camuflado":
	{
		sprite_index = spr_inimigo_mordedor_sorrateiro_parado;
		image_index = 0;
		
		if(place_meeting(x, y - 10, obj_player))
		{
			estado = "attack";
			image_index = 0;
		}
		break;
	}
	
	case "attack":
	{
		sprite_index = spr_inimigo_mordedor_sorrateiro_attack;
		
		//causando dano
		if(image_index >= 5 && dano == noone)
		{
			//cria objeto dano
			dano = instance_create_layer(x, y - sprite_height/4, layer, obj_dano);
			dano.dano = dano_mordida;
			dano.pai = id;
			// definindo tamanho do dano para o tamanho do inimigo
			dano.image_xscale = image_xscale;
			dano.image_yscale = image_yscale;
		}
		
		//finalizando a animação
		if(image_index > image_number -1)
		{
			if(instance_exists(dano))
			{
				instance_destroy(dano);
				dano = noone;
			}
			dano = noone;
			estado = "recuperando";
			timer_reset = game_get_speed(gamespeed_fps) * 2;
		}
		break;
	}
	
	case "recuperando":
	{
		sprite_index = spr_inimigo_mordedor_sorrateiro_recuperando;
		image_index = image_number-1;
		image_speed = 0;
		
		timer_reset--;
		
		if(timer_reset <= 0)
		{
			if(!place_meeting(x, y -10, obj_player))
			{
				estado = "camuflado";
			}
			else
			{
				timer_reset = 30;
			}
		}
		break;
	}
	
	case "hit":
	{
		if(sprite_index != spr_inimigo_mordedor_sorrateiro_hit)
		{
			//iniciando o que for preciso para este estado
			image_index = 0;
		}
		sprite_index = spr_inimigo_mordedor_sorrateiro_hit;
		
		//condicao de troca de estado
		if(vida_atual > 0)
		{
			if(image_index >= image_number -1)
			{
				estado = "camuflado";
			}
		}
		else
		{
			if(image_index >= 3)
			{
				estado = "dead";
			}
		}
		break;
	}
	
	case "dead":
	 {
		 
		 if(sprite_index != spr_inimigo_mordedor_sorrateiro_dead)
		{
			//iniciando o que for preciso para este estado
			image_index = 0;
		}
		
		 sprite_index = spr_inimigo_mordedor_sorrateiro_dead;
		 
		//morrendo de verdade
		if(image_index > image_number - 1)
		{
			image_speed = 0;
			image_alpha -= .01;
			if(image_alpha <= 0)
			{
				instance_destroy();
			}
		}
	 }
	
}