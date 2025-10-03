extends CharacterBody2D

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0
@export var wait_time: float = 0.5

var _target_point: Vector2
var _moving_to_b := true
var _waiting := false

func _ready():
	_target_point = point_b

func _physics_process(delta):
	if _waiting:
		return

	var direction = (_target_point - global_position).normalized()
	var distance = global_position.distance_to(_target_point)

	if distance < 2.0:
		# Arrived at target
		_moving_to_b = !_moving_to_b
		_target_point = point_b if _moving_to_b else point_a
		_wait()
	else:
		velocity = direction * speed
		move_and_slide()
		
func _wait():
	_waiting = true
	velocity = Vector2.ZERO
	await get_tree().create_timer(wait_time).timeout
	_waiting = false
