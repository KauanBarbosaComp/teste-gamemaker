// --- 1. PAUSA O JOGO ---
// Desativa TODAS as instâncias do jogo
instance_deactivate_all(true);

// ...exceto este objeto. Ele precisa continuar funcionando para
// poder ler o teclado e desenhar o menu.
instance_activate_object(obj_menu_pausa);

// --- 2. Configura as Opções do Menu ---
opcoes = [
    "Retomar",
    "Voltar ao Menu"
];

op_selecionada = 0;
op_total = array_length(opcoes);