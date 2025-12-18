shader_type canvas_item;

uniform float onoff;

void vertex() {
	// Called for every vertex the material is visible on.
}

int approximately_zero(vec3 vector1, vec3 vector2)
{
	int i = 0;
	
	float a = vector1.x - vector2.x;
	
	float b = vector1.y - vector2.y;
	
	float c = vector1.z - vector2.z;
	
	if (0.01 >= a && a >= -0.01)
	{
		i++;
	}
		
	
	if (0.01 >= b && b >= -0.01)
	{
		i++;
	}
		
	
	if (0.01 >= c && c >= -0.01)
	{
		i++;
	}
		
	
	return i;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 original_color = texture(TEXTURE, UV);
	
	float greyscale = (original_color.r + original_color.g + original_color.b) / 3.0f;
	
	vec3 greyscale_color = vec3(greyscale, greyscale, greyscale);
	
	if (COLOR.xyz == vec3(255.0/255.0, 111.0/255.0, 76.0/255.0))
		COLOR.xyz = vec3(0.0, 0.0, 1.0);

	//vec3(37.00/255.00, 150.00/255.00, 190.00/255.00)
	if (approximately_zero(COLOR.xyz, vec3(170.00/255.00, 90.00/255.00, 73.00/255.00)) == 3)
		COLOR.xyz = vec3(0.0, 1.0, 0.0);	
	
	
	//COLOR.xyz = greyscale_color;
	COLOR.a = original_color.a;
}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
