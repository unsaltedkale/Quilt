class_name WallStickComponent
extends Node

@export_subgroup("Settings")
@onready var player = get_parent()

var temp_acc = 1.2
var wall_stick: bool = false
var p_moving: bool = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		p_moving = true
	else:
		p_moving = false

func handle_wall(body: CharacterBody2D, _delta: float):
	if body.is_on_wall() and not body.is_on_floor():
		if p_moving and not player.is_magical_wall:
			wall_stick = true
		elif p_moving and player.is_magical_wall:
			wall_stick = false
	else:
		wall_stick = false
	if wall_stick:
		body.velocity.y += 50 * temp_acc
		temp_acc += 0.1
		if body.velocity.y > 240: # some numer
			body.velocity.y = 240
		print("body hit wall")
	else:
		pass
