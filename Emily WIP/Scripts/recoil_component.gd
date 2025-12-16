class_name RecoilComponent
extends Node

@export_subgroup("Settings")

var can_shoot
var force : Vector2 = Vector2(3000,4000) 
var player_direction 

func handle_recoil(body: CharacterBody2D, direction: float):
	can_shoot = body.can_shoot
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		player_direction = body.get_local_mouse_position().normalized()
		body.velocity -= player_direction * force
		
		print("player direction ", player_direction, "player act pos ", body.global_position)
	
