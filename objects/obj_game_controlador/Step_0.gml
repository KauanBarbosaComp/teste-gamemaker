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