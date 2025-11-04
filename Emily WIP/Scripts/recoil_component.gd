class_name RecoilComponent
extends Node

@export_subgroup("Settings")

var force = 300
var player_direction 

func handle_recoil(body: CharacterBody2D, direction: float):
	if Input.is_action_just_pressed("fire_projectile"):
		var mouse_pos = get_viewport().get_mouse_position() * get_viewport().get_canvas_transform()
		player_direction = (body.position - mouse_pos).normalized()
		body.velocity += player_direction * force
		print("player changed pos ", player_direction, "player act pos ", body.position, " mouse position ", body.position - mouse_pos)
		# x position is too large
	
