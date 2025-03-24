/// Step Event
// Update time
time += pulse_speed;

// Calculate the current glow distance using a sine wave
glow_distance = min_glow + (max_glow - min_glow) * (sin(time) * 0.5 + 0.5);

// Handle different behaviors based on game path
if (game_path == "consume") {
    // CONSUME PATH - Original consumption behavior
    if (instance_exists(obj_soul_IT)) {
        if (obj_soul_IT.just_consumed) {
            // Increment consume count
            consume_count += 1;
            obj_soul_IT.just_consumed = false;
            
            // Handle effects based on consume count
            if (consume_count == 1) {
                // Play consume sound for first consume
                if (audio_exists(snd_consume)) {
                    audio_play_sound(snd_consume, 10, false);
                }
                max_glow *= 0.6; // Reduce to 60%
            } else if (consume_count == 2) {
                // Play consume sound for second consume
                if (audio_exists(snd_consume)) {
                    audio_play_sound(snd_consume, 10, false);
                }
                max_glow *= 0.3; // Reduce to 30% of original
            } else if (consume_count == 3) {
                // No glow on third consume
                max_glow = 0;
                min_glow = 0;
                glow_distance = 0;
                // Play consume sound with higher priority on final consume
                if (audio_exists(snd_consume)) {
                    audio_play_sound(snd_consume, 15, false);
                }
                // Start fading out music
                music_fading = true;
            }
        }
    }
} else {
    // SEPARATE PATH - Behavior for separation
    if (instance_exists(obj_soul_IT) && !separate_triggered) {
        // Check if player is in contact with IT soul
        var is_touching = collision_circle(
            obj_soul_IT.x, obj_soul_IT.y, 
            32, // Fixed collision radius
            obj_soul, 
            false, true
        );
        
        if (is_touching) {
            // Trigger the separation
            separate_triggered = true;
            
            // Store IT soul position before destroying
            var it_soul_x = obj_soul_IT.x;
            var it_soul_y = obj_soul_IT.y;
            
            // Create 5-7 freed souls
            var num_souls = irandom_range(5, 7);
            for (var i = 0; i < num_souls; i++) {
                var soul = instance_create_layer(it_soul_x, it_soul_y, "Instances", obj_soul_freed);
                
                if (instance_exists(soul)) {
					// Set random direction with slower speed
					soul.direction = random(360);
					soul.speed = random_range(0.5, 0.7); // Slower movement
                    soul.image_alpha = 0.8; // Higher visibility
                    soul.image_angle = 0; // No rotation
                    
                    // Debug message
                    show_debug_message("Created freed soul " + string(i));
                }
            }
            
            // Play separation sound starting at 133 seconds
            if (audio_exists(mus_separate)) {
                // VERY SLOW fade out for initial music instead of stopping
                audio_sound_gain(mus_separate, 0, 8000); // 8 second fade out
                
                // Play the breaking sound effect
                secondary_music = audio_play_sound(mus_separate, 15, false);
                audio_sound_set_track_position(secondary_music, 133);
                secondary_music_playing = true;
                secondary_music_timer = 0;
            }
            
            // Remove the IT soul
            instance_destroy(obj_soul_IT);
        }
    }
    
    // Handle light fading for separate path
	if (game_path == "separate" && separate_triggered) {
	    // Fade the entire light column by reducing transparency
	    light_alpha -= 0.01; // Medium fade rate for transparency
	    if (light_alpha < 0) light_alpha = 0;
	}
}

// Handle music fading for consume path
if (music_fading && game_path == "consume") {
    music_volume -= music_fade_speed;
    if (music_volume <= 0) {
        music_volume = 0;
        
        if (audio_exists(mus_noHelp)) {
            audio_sound_gain(mus_noHelp, 0, 0);
        }
        
        music_fading = false;
    } else {
        if (audio_exists(mus_noHelp)) {
            audio_sound_gain(mus_noHelp, music_volume, 0);
        }
    }
}

// Handle secondary music for separate path (EXTREMELY slow fade)
if (secondary_music_playing && separate_triggered) {
    secondary_music_timer++;
    
    // After the sound plays for a while, start EXTREMELY slow fade
    if (secondary_music_timer >= room_speed * 15) { // Wait 15 seconds before starting fade
        if (audio_exists(secondary_music)) {
            var current_volume = audio_sound_get_gain(secondary_music);
            // Ultra slow fade - only 0.0001 per step (600x slower than original)
            current_volume = max(0, current_volume - 0.0001);
            audio_sound_gain(secondary_music, current_volume, 0);
        }
    }
    
    // After 2 seconds of the breaking sound, start mus_theLocket
    if (secondary_music_timer >= secondary_music_delay && !audio_is_playing(mus_theLocket)) {
        if (audio_exists(mus_theLocket)) {
            var locket_music = audio_play_sound(mus_theLocket, 10, true);
            audio_sound_set_track_position(locket_music, 15); // Start at 15 seconds
            audio_sound_gain(locket_music, 0, 0); // Start silent
            audio_sound_gain(locket_music, 1, 2000); // Fade in over 2 seconds
        }
    }
}