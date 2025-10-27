class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 600 #change 
@export var jump_component: JumpComponent

var previous_velocity = 0

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * speed
	$"../AnimatedSprite2D".play("walk")
