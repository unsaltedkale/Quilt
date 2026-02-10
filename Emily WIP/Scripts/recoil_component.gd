class_name RecoilComponent
extends Node

@export_subgroup("Settings")
@onready var player = get_parent()
var can_shoot
var force : Vector2 = Vector2(2500,1500)
var player_direction
var joystick_direction
var input: Vector2

func handle_recoil(body: CharacterBody2D, direction: float):
	can_shoot = body.can_shoot
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	if can_shoot:
		if Input.is_action_just_pressed("fire_projectile") or joystick_direction > Vector2(0,0) or joystick_direction < Vector2(0,0):
			body.velocity = recoil_velocity_equation()
			#print("player direction ", player_direction, "player act pos ", body.global_position)
		
func recoil_velocity_equation():
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	player_direction = player.get_local_mouse_position().normalized()
	var value = (player_direction) * force * -1
	print("joystick: ", joystick_direction, "player: ", player_direction)
	#var value = player_direction * force * -1 
	#print((rad_to_deg(value.angle())))
	return value
	
