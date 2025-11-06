class_name RecoilComponent
extends Node

@export_subgroup("Settings")

var force : Vector2 = Vector2(3000,4000) 
var player_direction 

func handle_recoil(body: CharacterBody2D, direction: float):
	if Input.is_action_just_pressed("fire_projectile"):
		player_direction = body.get_local_mouse_position().normalized()
		body.velocity -= player_direction * force
		print("player direction ", player_direction, "player act pos ", body.global_position)
	
