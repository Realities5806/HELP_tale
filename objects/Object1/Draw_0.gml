/// Draw Event
// Get screen dimensions
var screen_width = room_width;
var screen_height = room_height;

// Calculate center position
var center_x = screen_width / 2;

// Fill the screen with black
draw_set_color(c_black);
draw_rectangle(0, 0, screen_width, screen_height, false);

// Only draw the glow if max_glow is greater than 0 and has some visibility
if (max_glow > 0 && glow_distance > 0 && light_alpha > 0) {
    // Set up additive blending for glow effect
    gpu_set_blendmode(bm_add);
    
    // Draw the central pillar with reduced brightness and fading transparency
    draw_set_color(glow_color);
    draw_set_alpha(glow_alpha * 0.5 * light_alpha); // Apply overall transparency
    draw_rectangle(center_x - 6, 0, center_x + 6, screen_height, false); // Narrower pillar
    
    // Draw the glow effect with a simple radial falloff
    var steps = 40;
    for (var i = 1; i <= steps; i++) {
        // Calculate distance from center and alpha for this step
        var distance = (i / steps) * glow_distance;
        var current_alpha = glow_alpha * 0.4 * (1 - (i / steps)); // Further reduced brightness
        
        // Set alpha for this step
        draw_set_alpha(current_alpha);
        
        // Draw vertical strips with decreasing alpha
        draw_rectangle(center_x - 6 - distance, 0, center_x + 6 + distance, screen_height, false);
    }
    
    // Reset drawing state
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}