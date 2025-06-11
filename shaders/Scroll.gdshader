shader_type canvas_item;

uniform vec2 direction;
uniform float speed;
uniform float time;

void fragment() {
	vec2 move = direction * time * speed;
	COLOR = texture(TEXTURE, UV+move);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
