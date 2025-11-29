// 1. Criar Efeito Visual de Explosão
// instance_create_layer(x, y, layer, obj_efeito_explosao);

// 2. Criar Dano em Área (Explosão)
var explosao = instance_create_layer(x, y, layer, obj_dano);
explosao.dano = 5; // Dano alto da explosão
explosao.pai = noone; // Define quem criou (para não dar erro no obj_dano)
explosao.image_xscale = 3; // Aumenta o tamanho do hitbox (Explosão grande)
explosao.image_yscale = 3; 

// Nota: Como o objeto torreta vai deixar de existir agora, 
// certifique-se que o "Clean Up" do obj_dano lida com "pai" inexistente 
// ou defina "explosao.pai = noone" se seu código permitir.