extends AnimatableBody2D

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0
@export var wait_time: float = 0.5
@export var lever_path: NodePath
var player : Player

var _target_point: Vector2
var _waiting = false
var _reached_target = false

@export var dot = preload("res://Alex's Folder/tscns/zipline_dot.tscn")
@export var line = preload("res://Alex's Folder/tscns/zipline_line.tscn")

func _ready():
	_target_point = point_a
	
	if lever_path != NodePath():
		var lever = get_node(lever_path)
		lever.changed.connect(_on_lever_changed)
		
		_on_lever_changed(lever.state)
	
	var d = dot.instantiate()
	d.global_position = point_a
	
	var e = dot.instantiate()
	e.global_position = point_b
	
	var del = line.instantiate()
	del.clear_points()
	del.add_point(point_a)
	del.add_point(point_b)
	
	get_tree().current_scene.add_child.call_deferred(d)
	get_tree().current_scene.add_child.call_deferred(e)
	get_tree().current_scene.add_child.call_deferred(del)

func _on_lever_changed(new_state: String):
	if new_state == "right":
		await get_tree().create_timer(1.0).timeout
		_target_point = point_b
		
	if new_state == "left":
		await get_tree().create_timer(1.0).timeout
		_target_point = point_a

func reset_position():
	global_position = point_a
	_target_point = point_a
	
func _on_player_death():
	reset_position.call_deferred()

func _physics_process(delta):
	if player != null:
		if not player.player_death.is_connected(_on_player_death):
			player.player_death.connect(_on_player_death)
	else:
		player = get_tree().get_first_node_in_group("Player")
	
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
	
	
	
	
