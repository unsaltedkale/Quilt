class_name InputComponent
extends Node

var input_horizontal: float = 0.0
var input_recoil_vert: float = 0.0
var input_recoil_horz: float = 0.0

func _process(delta: float) -> void:
	input_horizontal = Input.get_axis("move_left","move_right")
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
	
func get_shoot_input() -> bool:
	return Input.is_action_just_pressed("fire_projectile")
	
func get_crouch_input() -> bool:
	return Input.is_action_just_pressed("crouch")
	
func get_recoil_input(delta: float) -> void:
	input_recoil_vert = Input.get_axis("recoil_up","recoil_down")
	input_recoil_horz = Input.get_axis("recoil_right","recoil_left") 
