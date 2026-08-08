shader_type canvas_item;

uniform bool clipping_enabled = false;
uniform float target_screen_y = 1.0;

void fragment() {
	vec4 pixel = texture(TEXTURE, UV) * COLOR;

	if (clipping_enabled && SCREEN_UV.y > target_screen_y) {
		pixel.a = 0.0;
	}

	COLOR = pixel;
}