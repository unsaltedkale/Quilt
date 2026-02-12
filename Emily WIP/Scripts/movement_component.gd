class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 600 #change 
@export var jump_component: JumpComponent
@onready var Player = get_parent()
@export var prev_player_is_cutscene: bool
@export var cutscene_frozen: bool

var previous_velocity = 0

func _ready():
	prev_player_is_cutscene = false

func _process(delta) -> void:
	if prev_player_is_cutscene != null && Player.is_cutscene != null:
		if Player.is_cutscene != prev_player_is_cutscene:
				Player.velocity.x = 0
				Player.velocity.y = 0
				prev_player_is_cutscene = Player.is_cutscene
				cutscene_frozen = true
		elif Player.is_cutscene == false:
			cutscene_frozen = false
			pass

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	#if recoil, launch in air a lil
	var delta: float = get_process_delta_time()
	var traction = 15000
	if cutscene_frozen == false:
		body.velocity.x = move_toward(body.velocity.x, direction * speed, delta * traction)
	
	
