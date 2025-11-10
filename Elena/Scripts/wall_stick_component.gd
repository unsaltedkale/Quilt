class_name WallStickComponent
extends Node

@export_subgroup("Settings")

var temp_acc = 1.2


func handle_wall(body: CollisionShape2D, _delta: float):
	if body.name == "CollisionShape2D3":
		#if body.is_on_wall():
			#timer stick
			#body.velocity.y = 3 * temp_acc
			print("body hit wall")
