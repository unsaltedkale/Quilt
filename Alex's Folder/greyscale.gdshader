shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 original_color = texture(TEXTURE, UV);
	
	float greyscale = (original_color.r + original_color.g + original_color.b) / 3.0f;
	
	vec3 greyscale_color = vec3(greyscale, greyscale, greyscale);
	
	if (COLOR.xyz == vec3(255.0/255.0, 111.0/255.0, 76.0/255.0))
		COLOR.xyz = vec3(1.0, 1.0, 1.0);
		
	else if (COLOR.xyz == vec3(37.0/255.0, 150.0/255.0, 190.0/255.0))
		COLOR.xyz = vec3(0.0, 0.0, 1.0);	
	
	
	//COLOR.xyz = greyscale_color;
	COLOR.a = original_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
