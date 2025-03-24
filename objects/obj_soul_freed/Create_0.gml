/// Create Event
// Starting properties with higher visibility
image_alpha = 0.9; // Higher visibility (was 0.75)
fade_speed = 0.003; // Slower fade (was 0.005)

// Small variations in size but keep original look
image_xscale = random_range(0.95, 1.05);
image_yscale = image_xscale;

// NO random rotation - keep it upright
image_angle = 0;

// Increase depth to make sure it's visible
depth = -1000; // Ensure it's drawn on top

// Small random rotation
// REMOVED: image_angle = random(360);

// Debug message to confirm creation
show_debug_message("Soul freed created at: " + string(x) + "," + string(y));