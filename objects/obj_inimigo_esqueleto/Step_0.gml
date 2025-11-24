var chao = place_meeting(x, y + 1, obj_block);

if (!chao)
{
	velv += GRAVIDADE* massa;
}
 
 /*if(mouse_check_button_pressed(mb_right))
 {
	estado = "attack";
 }*/
 


 switch(estado)
 {
	 case "parado":
	 {
		 velh = 0;
		 timer_estado ++;
		 if(sprite_index != spr_inimigo_esqueleto_idle)
		{
			//iniciando o que for preciso para este estado
			image_index = 0;
		}
		sprite_index = spr_inimigo_esqueleto_idle;
		
		//condicao de troca de estado
		if(position_meeting(mouse_x, mouse_y, self))
		{
			if(mouse_check_button_pressed(mb_right))
			{
				estado = "hit";
			}
		}
		
		//indo para o estado de patrulha
		if(irandom(timer_estado) > 300)
		{
			estado = choose("andando","parado","andando");
			timer_estado = 0;
		}
		//atacando
		scr_ataca_player_melee(obj_player, dist, xscale);
		break;
	 }
	 case "andando":
	 {
		timer_estado++;
		if(sprite_index != spr_inimigo_esqueleto_walk)
		{
			velh = choose(1, -1);
			image_index = 0;
		}
		sprite_index = spr_inimigo_esqueleto_walk;
		
		
		//condicao de saida do estado
		if(irandom(timer_estado) > 300)
		{
			estado = choose("parado", "andando", "parado");
			timer_estado = 0;
		}
		//atacando
		scr_ataca_player_melee(obj_player, dist, xscale);
		break;
	 }
	 
	 case "hit":
	 {
		if(sprite_index != spr_inimigo_esqueleto_hit)
		{
			//iniciando o que for preciso para este estado
			image_index = 0;
		}
		sprite_index = spr_inimigo_esqueleto_hit;
		
		//condicao de troca de estado
		if(vida_atual > 0)
		{
			if(image_index > image_number -1)
			{
				estado = "parado";
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
	 case "attack":
	 {
		if(sprite_index != spr_inimigo_esqueleto_attack)
		{
			image_index = 0;
		}
		sprite_index = spr_inimigo_esqueleto_attack;
		
		//saindo do estado
		if(image_index > image_number -1)
		{
			estado = "parado"
		}
		break;
	 }
	 
	 case "dead":
	 {
		 if(sprite_index != spr_inimigo_esqueleto_dead)
		{
			//iniciando o que for preciso para este estado
			image_index = 0;
		}
		
		 sprite_index = spr_inimigo_esqueleto_dead;
		 
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
		 
		break; 
	 }
 }