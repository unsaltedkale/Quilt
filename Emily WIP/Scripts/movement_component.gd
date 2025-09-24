class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 100 #change 

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * speed
