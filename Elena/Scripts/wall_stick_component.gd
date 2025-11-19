class_name WallStickComponent
extends Node

@export_subgroup("Settings")

var temp_acc = 1.2
var wall_stick: bool = false

func handle_wall(body: CharacterBody2D, _delta: float):
	if body.is_on_wall() and not body.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			wall_stick = true
			print("wall stick true")
		else:
			wall_stick = false
	else:
		wall_stick = false
	if wall_stick:
		body.velocity.y += 50 * temp_acc
		temp_acc += 0.1
		if body.velocity.y > 240: # some numer
			body.velocity.y = 240
		print("body hit wall", body.velocity)
