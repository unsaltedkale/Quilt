extends AnimatableBody2D
class_name LeverPlatform

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0
@export var wait_time: float = 0.5
@export var lever: Lever
@onready var gear = $Gear
@onready var _target_point: Vector2 = point_a
var _waiting = false
var _reached_target = false
@export var dot = preload("res://Alex's Folder/tscns/zipline_dot.tscn")
@export var line = preload("res://Alex's Folder/tscns/zipline_line.tscn")

func _ready():
	gear.play("idle")
	point_a += get_parent().get_parent().global_position
	point_b += get_parent().get_parent().global_position
	
	lever.changed.connect(_on_lever_changed)
	_on_lever_changed(lever.isLeft) #Make sure we're pointed at the right point
	
	#Make a dot at points a and b
	var dot_a = dot.instantiate()
	dot_a.global_position = point_a
	var dot_b = dot.instantiate()
	dot_b.global_position = point_b
	#Make a line between those points
	var del = line.instantiate()
	del.clear_points()
	del.add_point(point_a)
	del.add_point(point_b)
	#Add those points to the scene as a child of the lever platform
	get_tree().current_scene.add_child.call_deferred(dot_a)
	get_tree().current_scene.add_child.call_deferred(dot_b)
	get_tree().current_scene.add_child.call_deferred(del)
	setup.call_deferred() #Grab player and connect to death signal
	
func setup():
	var player : Player = get_tree().get_first_node_in_group("Player")
	player.player_death.connect(_on_player_death)

func _on_lever_changed(isLeft: bool):
	if !isLeft:
		await get_tree().create_timer(1.0).timeout
		_target_point = point_b
	else:
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
		gear.play("idle")
		if direction.x > 0:
			gear.flip_h = false
		else: 
			gear.flip_h = true
	else:
		gear.play("move")
		global_position += direction * speed * delta

func reset_position():
	global_position = point_a
	_target_point = point_a

func _on_player_death():
	reset_position.call_deferred()

func _wait():
	_waiting = true
	await get_tree().create_timer(wait_time).timeout
	_waiting = false
