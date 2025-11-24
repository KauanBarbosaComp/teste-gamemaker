// --- 1. Ler Inputs das Setas e Enter ---
var _key_down = keyboard_check_pressed(vk_down);
var _key_up = keyboard_check_pressed(vk_up);
var _key_enter = keyboard_check_pressed(vk_enter);

// (Bônus) Permite que "Escape" também despause o jogo
var _key_pause = keyboard_check_pressed(vk_escape);

// --- 2. Mover Seleção ---
if (_key_down) {
    op_selecionada++;
    if (op_selecionada >= op_total) {
        op_selecionada = 0;
    }
}
if (_key_up) {
    op_selecionada--;
    if (op_selecionada < 0) {
        op_selecionada = op_total - 1;
    }
}

// --- 3. Executar Ação (Enter ou Escape) ---

// Se "Retomar" for selecionado ou se o jogador apertar "Pause" de novo
if ((_key_enter && op_selecionada == 0) || _key_pause)
{
    // --- DESPAUSAR O JOGO ---
    instance_activate_all(); // Reativa todos os objetos
    instance_destroy();      // Destrói o objeto de menu de pausa
}

// Se "Voltar ao Menu" for selecionado
if (_key_enter && op_selecionada == 1)
{
    // --- DESPAUSAR O JOGO PRIMEIRO ---
    // (Importante: reative tudo antes de sair da room)
    instance_activate_all(); 
    
    // Vá para a sua room de menu principal (como você mencionou)
    room_goto(rm_jogo_inicial); 
}