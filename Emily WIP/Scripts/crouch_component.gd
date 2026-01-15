extends Node
class_name CrouchComponent
@export var crouch_component: CrouchComponent
@onready var player = $".."


func handle_crouch(body: CharacterBody2D, direction: float) -> void:
	if Input.is_action_just_pressed("crouch"):
		player.scale.y *= .75
		print("is crouching")
	if Input.is_action_just_released("crouch"):
		player.scale.y /= .75
		print("stopped crouching")
