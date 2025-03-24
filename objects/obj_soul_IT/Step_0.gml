/// Step Event
// Check if touching the player soul
touching_soul = place_meeting(x, y, obj_soul);

// COOLDOWN HANDLING
if (cooldown_active) {
    cooldown_timer++;
    if (cooldown_timer >= cooldown_duration) {
        cooldown_active = false;
        cooldown_timer = 0;
    }
}

// TOUCH HANDLING - Start showing text after 3 seconds of contact
if (touching_soul && !cooldown_active) {
    touch_timer++;
    
    if (touch_timer >= text_appear_delay) {
        // Show text after delay
        show_text = true;
        
        // Update text progress for typewriter effect
        if (text_progress < string_length(text_string)) {
            text_progress += text_speed;
        } else {
            text_fully_visible = true;
        }
    }
} else {
    // Reset touch timer and text when not touching or during cooldown
    if (!touching_soul) {
        touch_timer = 0;
        show_text = false;
        text_progress = 0;
        text_fully_visible = false;
        text_alpha = 1.0;
    }
}

// Z KEY HANDLING
if (touching_soul && !cooldown_active) {
    if (keyboard_check(ord("Z"))) {
        // Fade text while Z is held
        if (show_text && text_alpha > 0) {
            text_alpha -= text_fade_speed;
            if (text_alpha <= 0) {
                text_alpha = 0;
            }
        }
        
        // Count consume time while Z is held
        consume_timer++;
        
        // After holding Z for 3 seconds, execute consumption
        if (consume_timer >= consume_delay) {
            just_consumed = true;
            consume_stage++;
            
            // Set scale based on stage
            if (consume_stage == 1) {
                image_xscale = 3;
                image_yscale = 3;
            } else if (consume_stage == 2) {
                image_xscale = 2;
                image_yscale = 2;
            } else if (consume_stage == 3) {
                // Signal to Object1 that this is the final consume before destroying
                just_consumed = true;
                
                // Allow a small delay for Object1 to process the consumption
                alarm[0] = 2; // Set alarm to destroy after 2 steps
            }
            
            // Start cooldown between consumes
            cooldown_active = true;
            cooldown_timer = 0;
            
            // Reset consume timer
            consume_timer = 0;
            
            // Reset text state
            show_text = false;
            text_progress = 0;
            text_fully_visible = false;
            text_alpha = 1.0;
            touch_timer = 0;
        }
    } else {
        // Reset consume timer when Z is released
        consume_timer = 0;
        
        // Gradually fade text back in when Z is released
        if (show_text && text_alpha < 1.0) {
            text_alpha += text_fade_speed;
            if (text_alpha > 1.0) {
                text_alpha = 1.0;
            }
        }
    }
}