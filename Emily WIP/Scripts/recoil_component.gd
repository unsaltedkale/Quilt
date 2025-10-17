class_name RecoilComponent
extends Node

@export_subgroup ("Settings")
@export var recoil_component : RecoilComponent
@export var input_component: InputComponent

var speed = .3

var speed_negative : bool = false
	
#mouse.x > the player.x to the right
func handle_movement(body: CharacterBody2D, want_to_shoot: bool) -> void: 
	if want_to_shoot:
		# use camera position for player later when camera follows player
		if get_viewport().get_mouse_position().x > (body.position.x-3050)/3.3 and speed_negative:
			speed = speed * 1
			speed_negative = true
		elif get_viewport().get_mouse_position().x > (body.position.x-3050)/3.3:
			speed = speed * -1
			speed_negative = true
		if get_viewport().get_mouse_position().x < (body.position.x-3050)/3.3 and speed_negative:
			speed = speed * -1
			speed_negative = false
		elif get_viewport().get_mouse_position().x < (body.position.x-3050)/3.3:
			speed = speed * 1
			speed_negative = false
			
		body.velocity.x = body.position.x * speed
		print("player position : ", body.global_position ," mouse position: ", get_viewport().get_mouse_position())
