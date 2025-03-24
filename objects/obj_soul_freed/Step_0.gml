// Moderate fading speed
image_alpha -= fade_speed * 0.7; // 30% slower than original

// Maintain constant movement - NO deceleration
// REMOVED: speed = max(0, speed - 0.01);

// Small random drift to make movement more natural
x += random_range(-0.2, 0.2);
y += random_range(-0.2, 0.2);

// Destroy instance when fully transparent
if (image_alpha <= 0) {
    instance_destroy();
}