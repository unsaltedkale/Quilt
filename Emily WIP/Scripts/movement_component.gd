class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 300 #change 
@export var jump_component: JumpComponent
@onready var Player = get_parent()
@export var prev_player_is_cutscene: bool

var previous_velocity = 0

func _ready():
	prev_player_is_cutscene = false

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	#if recoil, launch in air a lil
	var delta: float = get_process_delta_time()
	var traction = 2500
	if prev_player_is_cutscene != null && Player.is_cutscene != null:
		if Player.is_cutscene != prev_player_is_cutscene:
				body.velocity.x = 0
	else:
		body.velocity.x = move_toward(body.velocity.x, direction * speed, delta * traction)
	prev_player_is_cutscene = Player.is_cutscene
	
