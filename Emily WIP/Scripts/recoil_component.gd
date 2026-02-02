class_name RecoilComponent
extends Node

@export_subgroup("Settings")

var can_shoot
var force : Vector2 = Vector2(2500,1500)
var player_direction 
var joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")

func handle_recoil(body: CharacterBody2D, direction: float):
	can_shoot = body.can_shoot
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		player_direction = body.get_local_mouse_position().normalized() #+ body.joystick_direction.normalized()
		body.velocity = player_direction * force * -1
		
		#print("player direction ", player_direction, "player act pos ", body.global_position)
	
