class_name RecoilComponent
extends Node

@export_subgroup ("Settings")
@export var recoil_component : RecoilComponent
@export var input_component: InputComponent

var speed = 0

	
#mouse.x > the player.x to the right
func handle_movement(body: CharacterBody2D, want_to_shoot: bool) -> void: 
	if want_to_shoot:
		if get_viewport().get_mouse_position().x > body.position.x:
			speed = speed * -1
		elif get_viewport().get_mouse_position().x < body.position.x:
			speed = speed * 1
		body.velocity.x = body.position.x * speed
		#print("mouse : " + get_viewport().get_mouse_position().x)
