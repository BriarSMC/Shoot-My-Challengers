shader_type canvas_item;

uniform bool turnWhite;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 inputColor = texture(TEXTURE, UV);
	COLOR = turnWhite ? vec4(1.0, 1.0, 1.0, inputColor.a) : inputColor;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}