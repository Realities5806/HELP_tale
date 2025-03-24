/// Create Event
// Timing values (in frames at 60fps)
text_appear_delay = 180; // 3 seconds at 60fps
consume_delay = 180; // 3 seconds at 60fps
cooldown_duration = 120; // 2 seconds at 60fps

// Tracking variables for interactions
touching_soul = false;
touch_timer = 0;
consume_timer = 0;
just_consumed = false;
consume_stage = 0;
max_consume_stages = 3;

// Cooldown timer between consumes
cooldown_active = false;
cooldown_timer = 0;

// Text variables
show_text = false;
text_alpha = 1.0;
text_fade_speed = 0.05; // How quickly text fades when Z is held
text_string = "Hold Z to Consume";
text_progress = 0;
text_speed = 0.5; // Characters per step
text_x = room_width / 2;
text_y = room_height / 2;
text_fully_visible = false; // Track if text is fully visible

// Starting scale
image_xscale = 4;
image_yscale = 4;