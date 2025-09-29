class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 800 #change 
@export var jump_component: JumpComponent

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	# if jump_component.bool.is_jumping = false
	if body.is_on_floor():
		body.velocity.x = direction * speed
