class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -750.0 #change

var was_on_floor: bool = false
var is_jumping: bool = false
var is_falling: bool = false
var is_landing: bool = false


func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	is_jumping = body.velocity.y > 0 and not body.is_on_floor()
	is_falling = body.velocity.y < 0 and not body.is_on_floor()
	var current_on_floor: bool = body.is_on_floor()
	
	if not was_on_floor and current_on_floor:
		is_landing = true
		print("hit floor")
	else:
		is_landing = false
		
	if is_jumping:
		$"../AnimatedSprite2D".play("jump")
	elif is_falling:
		$"../AnimatedSprite2D".play("fall")
	elif is_landing:
		$"../AnimatedSprite2D".play("land")
	else:
		$"../AnimatedSprite2D".play("idle")
		
	was_on_floor = current_on_floor
