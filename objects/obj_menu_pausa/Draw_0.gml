// Pega o tamanho da tela
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// --- 1. Desenha um fundo escuro semi-transparente ---
draw_set_alpha(0.5); // 50% de transparência
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_alpha(1.0); // Reseta a transparência

// --- 2. Desenha as Opções do Menu ---
//draw_set_font(fnt_menu); // (Use a fonte que você criou)
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

var _x = _gui_w / 2;
var _y = _gui_h / 2;

for (var i = 0; i < op_total; i++)
{
    var _texto = opcoes[i];
    var _cor = c_white; // Cor padrão
    
    if (i == op_selecionada)
    {
        _cor = c_yellow; // Cor da seleção
    }
    
    // Define a cor
    draw_set_color(_cor);
    
    // Desenha o texto da opção
    draw_text(_x, _y + (i * 50), _texto);
    
    // Desenha o ponteiro
    if (i == op_selecionada) {
        draw_text(_x - 100, _y + (i * 50), ">");
    }
}

// --- 3. Reseta as configurações de desenho ---
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);