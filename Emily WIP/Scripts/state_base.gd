extends Node
class_name State

@export var player: CharacterBody2D
@export var speed: float = 800
@onready var an = $"../../AnimatedSprite2D"
var move_dir
var recoil: bool
var cutscene: bool
@export var state_name: String
var acceleration = 1500
var decceleration = 750

signal Transition

func Enter():
	pass

func Exit():
	pass
	
func Update(_delta):
	pass
	
func Physics_Update(_delta):
	pass

func _physics_process(_delta) -> void:
	player.get_node("QuiltCollider").disabled = false
	player.get_node("PhloCollider").disabled = true
	if player.find_child("StateMachine").current_state.state_name != "cutscene" && player.find_child("StateMachine").current_state.state_name != "recoil":
		move_dir = Input.get_axis("move_left","move_right")
		if move_dir !=0:
			player.velocity.x = move_toward(player.velocity.x, move_dir * speed, acceleration * _delta)
		elif move_dir == 0:
			player.velocity.x = move_toward(player.velocity.x, 0, decceleration * _delta)
	if player.is_phlo:
		#if find_parent("StateMachine").current_state.state_name != "phlo_walk" || find_parent("StateMachine").current_state.state_name != "phlo_fall" || find_parent("StateMachine").current_state.state_name != "phlo_jump" || find_parent("StateMachine").current_state.state_name != "phlo_cutscene":
			#Transition.emit(self,"phlowalk")
		player.get_node("QuiltCollider").disabled = true
		player.get_node("PhloCollider").disabled = false
	pass
