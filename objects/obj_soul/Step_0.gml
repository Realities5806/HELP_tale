/// Step Event for obj_soul
// Get keyboard inputs
var key_right = keyboard_check(vk_right);
var key_left = keyboard_check(vk_left);
var key_up = keyboard_check(vk_up);
var key_down = keyboard_check(vk_down);

// Calculate movement
var move_h = key_right - key_left;
var move_v = key_down - key_up;

// Check if moving diagonally
var is_diagonal = (move_h != 0 && move_v != 0);

// Calculate appropriate speed based on movement type
var current_speed = is_diagonal ? move_speed_diagonal : move_speed;

// Apply movement (no delta time to match original behavior)
x += move_h * current_speed;
y += move_v * current_speed;

// Clamp position to room boundaries
x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);