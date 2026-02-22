extends State
class_name Jump

@export var player: CharacterBody2D
@export var jump_velocity: float = -950.0 #change


func Physics_Update(_delta):
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			player.velocity.y = jump_velocity*_delta
