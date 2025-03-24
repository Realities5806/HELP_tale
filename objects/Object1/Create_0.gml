/// Create Event
// *** PATH SELECTION ***
// Change this variable to "separate" or "consume" to select the game path
game_path = "separate";  // Options: "consume" or "separate"

// Define the font loading function
function LoadGameFonts() {
    // Try multiple possible paths for the font file
    var font_paths = ["fnt_general.ttf", "datafiles/fnt_general.ttf", "fonts/fnt_general.ttf"];
    global.main_font = -1;
    
    // Try each path until the font loads
    for (var i = 0; i < array_length(font_paths); i++) {
        global.main_font = font_add(font_paths[i], 16, false, false, 32, 128);
        if (font_exists(global.main_font)) {
            show_debug_message("Font loaded successfully from: " + font_paths[i]);
            break;
        }
    }
    
    // Check if font loaded
    if (!font_exists(global.main_font)) {
        show_debug_message("WARNING: Font failed to load from all paths!");
        global.main_font = -1;
    }
}

// Animation and effect values
pulse_speed = 0.01;
max_glow_base = 150;
min_glow_base = 50;
glow_alpha_value = 0.5;
music_fade_speed = 0.002; // Changed from 0.01 to 0.002 (5x slower)

// Initialize variables
time = 0;           // Time tracker for the sine wave
max_glow = max_glow_base;     // Maximum glow distance from the pillar
min_glow = min_glow_base;      // Minimum glow distance from the pillar
glow_alpha = glow_alpha_value;   // Alpha (transparency) of the glow
light_alpha = 1.0; // Start fully visible

// Set glow color based on game path
if (game_path == "consume") {
    glow_color = make_color_rgb(255, 200, 200); // Slight red tint for consume path
} else {
    glow_color = c_white; // Pure white for separate path
}

// Counter for consumption
consume_count = 0;

// Music fade variables
music_fading = false;
music_volume = 1.0;

// Separate path variables
separate_triggered = false;
secondary_music_playing = false;
secondary_music_timer = 0;
secondary_music_delay = 120; // 2 seconds at 60fps

// Start in fullscreen
window_set_fullscreen(true);

// Load font if not already loaded
if (!variable_global_exists("main_font") || !font_exists(global.main_font)) {
    LoadGameFonts();
}

// Play appropriate music based on selected path
if (game_path == "consume") {
    if (audio_exists(mus_noHelp)) {
        var music_id = audio_play_sound(mus_noHelp, 10, true);
        if (music_id == -1) {
            show_debug_message("WARNING: Failed to play mus_noHelp!");
        }
    } else {
        show_debug_message("WARNING: mus_noHelp sound resource not found!");
    }
} else { // separate path
    if (audio_exists(mus_separate)) {
        var music_id = audio_play_sound(mus_separate, 10, true);
        if (music_id == -1) {
            show_debug_message("WARNING: Failed to play mus_separate!");
        }
    } else {
        show_debug_message("WARNING: mus_separate sound resource not found!");
    }
}