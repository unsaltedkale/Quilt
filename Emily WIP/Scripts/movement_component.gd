class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 600 #change 
@export var jump_component: JumpComponent

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * speed
	if body.velocity.x > 0:
		$"../AnimatedSprite2D".flip_h = false
		$"../AnimatedSprite2D".play("walk")
	if body.velocity.x < 0:
		$"../AnimatedSprite2D".flip_h = true
		$"../AnimatedSprite2D".play("walk")
	else:
		$"../AnimatedSprite2D".play("idle")
	# when acceleration decreasing : play stop animation
