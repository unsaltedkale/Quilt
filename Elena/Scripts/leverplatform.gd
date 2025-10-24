extends AnimatableBody2D

@export var position_a: Vector2
@export var position_b: Vector2
@export var speed: float = 100.0 

var target_position: Vector2 

func _ready():
	target_position = position_a
	
func _process(delta):
	position = position.move_toward(target_position, speed * delta)
	
func set_target(is_on: bool):
	target_position = is_on ? position_b : position_a 
