class_name RecoilComponent
extends Node

@export_subgroup("Settings")

var can_shoot
var force : Vector2 = Vector2(2500,1500)
var joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
@onready var Player = get_parent()

func handle_recoil(body: CharacterBody2D, direction: float):
	can_shoot = body.can_shoot
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		body.velocity = recoil_velocity_equation()
		
		#print("player direction ", player_direction, "player act pos ", body.global_position)
	
func recoil_velocity_equation():
	var player_direction = Player.get_local_mouse_position().normalized()
	var value = player_direction * force * -1
	#print((rad_to_deg(value.angle())))
	return value
	
