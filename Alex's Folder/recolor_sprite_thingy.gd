extends AnimatedSprite2D

@onready var player = $".."

func _physics_process(delta):
	if player.collected_objects == 0:
		modulate = Color(0, 1, 1)
	else:
		modulate = Color(1, 1, 1)
