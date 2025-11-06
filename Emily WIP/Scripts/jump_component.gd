class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -950.0 #change

func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	
