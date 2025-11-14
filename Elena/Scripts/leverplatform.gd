extends AnimatableBody2D

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0
@export var wait_time: float = 0.5
@export var lever_path: NodePath

var _target_point: Vector2
var _waiting = false
var _reached_target = false


func _ready():
	_target_point = point_a
	
	if lever_path != NodePath():
		var lever = get_node(lever_path)
		lever.changed.connect(_on_lever_changed)
		
		_on_lever_changed(lever.state)

func _on_lever_changed(new_state: String):
	if new_state == "right":
		await get_tree().create_timer(1.0).timeout
		_target_point = point_b
		
	if new_state == "left":
		await get_tree().create_timer(1.0).timeout
		_target_point = point_a
		
	

func _physics_process(delta):
	if _waiting:
		return

	var direction = (_target_point - global_position).normalized()
	var distance = global_position.distance_to(_target_point)

	if distance < 2.0:
		_reached_target = true
		global_position = _target_point
	
	else:
		global_position += direction * speed * delta

func _wait():
	_waiting = true
	await get_tree().create_timer(wait_time).timeout
	_waiting = false
