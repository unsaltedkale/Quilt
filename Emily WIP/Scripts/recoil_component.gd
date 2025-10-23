class_name RecoilComponent
extends Node

@export_subgroup ("Settings")
@export var recoil_component : RecoilComponent
@export var input_component: InputComponent

var speed = .3

var speed_negative : bool = false

	
#mouse.x > the player.x to the right
func handle_movement(body: CharacterBody2D, want_to_shoot: bool) -> void: 
	var mouse_pos : Vector2 = get_viewport().get_mouse_position() 
	var player_pos : Vector2 = body.position * get_viewport().get_canvas_transform()
	if want_to_shoot:
		# use camera position for player later when camera follows player
		if mouse_pos > player_pos and speed_negative:
			speed = speed * 1
			speed_negative = true
		elif mouse_pos > player_pos:
			speed = speed * -1
			speed_negative = true
		
		body.velocity.x = body.position.x * speed
		print("player position : ", player_pos.x, " , ", player_pos.y ," mouse position: ", mouse_pos.x, " , ", mouse_pos.y)
