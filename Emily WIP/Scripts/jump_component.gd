class_name JumpComponent
extends Node
@onready var player = $"../Player"
@export_subgroup("Settings")
@export var jump_velocity: float = -950.0 #change
@export var wall_jump_vel: float = -2000
var wall_jump_push: float = -1000
var dist_from_ground: float = 10

func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if Input.is_action_just_pressed("jump"):
		if body.is_on_floor():
			body.velocity.y = jump_velocity
		if dist_from_ground > 10:
			print("distance from ground is: ", dist_from_ground)
			if body.is_on_wall() and Input.is_action_pressed("move_right"):
				body.velocity.y = wall_jump_vel
				body.velocity.x = -wall_jump_push
			if body.is_on_wall() and Input.is_action_pressed("move_left"):
				body.velocity.y = wall_jump_vel
				body.velocity.x = wall_jump_push
