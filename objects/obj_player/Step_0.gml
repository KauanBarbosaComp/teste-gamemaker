//declarando variaveis e controles de movimentacao
show_debug_message(vida_atual)
var right, left, jump, attack, dash;
var chao = place_meeting(x, y + 1, obj_block);

right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
jump = keyboard_check(ord("W"));
attack = keyboard_check(ord("K"));
dash = keyboard_check(ord("L"));

if(ataque_buff > 0) ataque_buff -= 5;

//codigo de movimentacao
velh = (right - left) * max_velh;
if(right && left && chao) estado = "parado"

//gravidade
if (!chao)
{
	if (velv < max_velv * 2)
	{
		velv += GRAVIDADE * massa;
	}
}

//iniciando maquina de estados
switch(estado)
{
	#region parado
	case "parado":
	{
		//comportamento do estado
		sprite_index = spr_player_parado1;

		
		//condicao de troca de estado
		//movendo
		if (right || left)
		{
			estado = "movendo";
		}
		else if (jump || velv != 0)
		{
			estado = "pulando"
			velv = (-max_velv * jump);
			image_index=0;
		}
		else if(attack)
		{
			estado = "ataque";
			velh = 0;
			combo = 0;
			image_index=0;
		}
		else if (dash)
		{
			estado = "dash";
			image_index = 0;
		}
		
		break;
	}
	#endregion
	
	#region movendo
	case "movendo":
	{
		//comportamento do estado de movimento
		sprite_index = spr_player_correndo;
		
		//condicao de troca de estado
		//Parado
		if (abs(velh) < .1)
		{
			estado = "parado";
			velh = 0;
		}
		else if (jump || velv != 0)
		{
			estado = "pulando"
			velv = (-max_velv * jump);
			image_index=0;
		}
		else if(attack)
		{
			estado = "ataque";
			velh = 0;
			image_index=0;
		}
		else if(dash){
			estado = "dash";
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region pulando
	case "pulando":
	{
		if(velv >0)
		{
			sprite_index = spr_player_caindo;
		}
		else
		{
			sprite_index = spr_player_pulo;
			//garantindo que a animacao nao se repita
			if (image_index >= image_number)
			{
				image_index = image_number - 1;
			}
		}
		
		//condicao de troca de estado
		//chega no chao
		if (chao)
		{
			estado = "parado";
			velv = 0;
		}
		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":
	{
		velh = 0;
		
		if(combo == 0)
		{
			sprite_index = spr_player_ataque1;
		}
		else if(combo == 1)
		{
			sprite_index = spr_player_ataque2;
		}
		else if(combo == 2)
		{
			sprite_index = spr_player_ataque3;
		}
		
		//criando o objeto de dano
		if(image_index >= 3 && image_index < 4  && dano == noone && posso)
		{
			dano = instance_create_layer(x + sprite_width/2, y - sprite_height/4, layer, obj_dano);
			dano.dano = ataque * ataque_mult;
			dano.pai = id;
			posso = false;
		}
		
		//configurando com o buff
		if(attack && combo < 2)
		{
			ataque_buff = room_speed;
		}
		if(ataque_buff && (combo < 2)&& image_index>= image_number -1)
		{
			combo++;
			image_index = 0;
			posso = true;
			ataque_mult += .5;
			if(dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
			
			//zerando o buffer
			ataque_buff = 0;
		}
		
		if (image_index > image_number -1)
		{
			estado = "parado";
			velh = 0;
			combo = 0;
			posso = true;
			ataque_mult = 1;
			if(dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		else if(dash){
			estado = "dash";
			image_index = 0;
			combo = 0;
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		if (velv != 0)
		{
			estado = "pulando"
			velv = (-max_velv * jump);
			image_index=0;
		}
		
		break;
	}
	#endregion
	
	#region hit
	case "hit":
	{
		if(sprite_index != spr_player_hit){
			image_index = 0;
		}
		sprite_index = spr_player_hit;
		
		//ficando parado quando leva dano
		velh = 0;
		//condição de troca de estado
		//checando se deve morrer
		if(vida_atual > 0){
			if(image_index > image_number - 1){
				estado = "parado";
			}
		}
		else{
			if(image_index >= image_number - 1){
				estado = "dead";
			}
		}
		//show_debug_message(vida_atual);
		break;
	}
	
	#endregion
	
	#region dash
	case "dash":
	{
		if(sprite_index != spr_player_dash){
			image_index = 0;
			sprite_index = spr_player_dash;
		}
		//velocidade
		velh = image_xscale * dash_vel;
		//saindo do estado
		if(image_index >= image_number -1){
			estado = "parado"
		}
		break;
	}
	#endregion
	
	#region dead
	case "dead":
	{
		velh = 0;
		if(sprite_index != spr_player_dead)
		{
			image_index = 0;
			sprite_index = spr_player_dead;
			velh = 0;
		}
		//ficando parado na morte
		if(image_index > image_number -1)
		{
			image_index = image_number -1;
		}
		
		break;
	}
	default:
	{
		estado = "parado";
	}
}
if(keyboard_check(vk_enter)) room_restart();


// --- Código de Pausa ---
// (Adicione isso ao seu código de Step já existente)

var _key_pause = keyboard_check_pressed(vk_escape);

// Se a tecla de pausa foi pressionada
if (_key_pause)
{
    // E se o jogo NÃO ESTIVER já pausado
    if (!instance_exists(obj_menu_pausa))
    {
        // Crie o objeto de menu de pausa
        instance_create_layer(0, 0, "Instances", obj_menu_pausa);
    }
}