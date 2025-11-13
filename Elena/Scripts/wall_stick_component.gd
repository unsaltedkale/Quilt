class_name WallStickComponent
extends Node

@export_subgroup("Settings")

var temp_acc = 1.2

func handle_wall(body: CharacterBody2D, _delta: float):
	if body.is_on_wall():
		body.velocity.y = 50 * temp_acc
		temp_acc += 0.1
		if body.velocity.y > 240: # some numer
			body.velocity.y = 240
		print("body hit wall", body.velocity)
