class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -750.0 #change

var is_jumping: bool = false
var is_falling: bool = false
var is_landing: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	is_jumping = body.velocity.y > 0 and not body.is_on_floor()
	is_falling = body.velocity.y < 0 and not body.is_on_floor()
	#is_landing = body.was_on_floor()
	
	if is_jumping:
		$"../AnimatedSprite2D".play("jump")
	if is_falling:
		$"../AnimatedSprite2D".play("fall")
	else:
		$"../AnimatedSprite2D".play("idle")
