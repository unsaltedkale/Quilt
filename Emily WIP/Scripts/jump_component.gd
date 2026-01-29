class_name JumpComponent
extends Node
@onready var player = $"../Player"
@export_subgroup("Settings")
@export var jump_velocity: float = -950.0 #change
@export var wall_jump_vel: float = -2000
var wall_jump_push: float = -1000
@onready var Player = get_parent()
@export var prev_player_is_cutscene: bool
@export var cutscene_frozen: bool

func _ready():
	prev_player_is_cutscene = false

func _process(delta) -> void:
	if prev_player_is_cutscene != null && Player.is_cutscene != null:
		if Player.is_cutscene != prev_player_is_cutscene:
				Player.velocity.y = 600
				prev_player_is_cutscene = Player.is_cutscene
				cutscene_frozen = true
		elif Player.is_cutscene == false:
			cutscene_frozen = false
			pass

func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if Input.is_action_just_pressed("jump"):
		if body.is_on_floor():
			body.velocity.y = jump_velocity
		if body.is_on_wall() and Input.is_action_pressed("move_right"):
			body.velocity.y = wall_jump_vel
			body.velocity.x = -wall_jump_push
		if body.is_on_wall() and Input.is_action_pressed("move_left"):
			body.velocity.y = wall_jump_vel
			body.velocity.x = wall_jump_push
