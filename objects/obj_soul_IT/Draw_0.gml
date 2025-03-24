/// Draw Event
// Draw self
draw_self();

// Only draw text if it's visible
if (show_text && text_alpha > 0) {
    // Use global font directly - no static caching
    var active_font = -1;
    if (font_exists(global.main_font)) {
        active_font = global.main_font;
    }
    
    // Set text properties
    draw_set_font(active_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 235, 235));
    draw_set_alpha(text_alpha);
    
    // Get the visible portion of the text
    var visible_text = string_copy(text_string, 1, floor(text_progress));
    
    // Draw text
    draw_text(text_x, text_y, visible_text);
    
    // Reset drawing properties
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}