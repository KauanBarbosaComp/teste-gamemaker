//declarando variaveis e controles de movimentacao
// abass aaehbiajcneo
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
		if(image_index >= 2 && dano == noone && posso)
		{
			dano = instance_create_layer(x + sprite_width/3, y - sprite_height/4, layer, obj_dano);
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
	
	#region dash
	case "dash":
	{
		sprite_index = spr_player_dash;
		//velocidade
		velh = image_xscale * dash_vel;
		if(image_index >= image_number -1){
			estado = "parado"
		}
	}
	#endregion
}
if(keyboard_check(vk_enter)) room_restart();