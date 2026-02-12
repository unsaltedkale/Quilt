extends AnimatedSprite2D

@onready var player = $".."

func _process(delta):
	get_material().set_shader_parameter("is_phlo",player.is_phlo)
	if player.collected_objects == 0:
		get_material().set_shader_parameter("onoff",0)
	elif player.collected_objects == 1:
		get_material().set_shader_parameter("onoff",1)
	elif player.collected_objects == 2:
		get_material().set_shader_parameter("onoff",2)
	else:
		get_material().set_shader_parameter("onoff",1)
