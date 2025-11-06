class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 600 #change 
@export var jump_component: JumpComponent

var previous_velocity = 0

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	#if recoil, launch in air a lil
	var delta: float = get_process_delta_time()
	var traction = 2500
	body.velocity.x = move_toward(body.velocity.x, direction * speed, delta * traction)
