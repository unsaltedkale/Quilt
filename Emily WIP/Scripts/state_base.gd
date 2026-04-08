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
var decceleration = 750 * 6
var sm
var smcs

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
	if player != null && sm == null:
		sm = player.find_child("StateMachine")
		smcs = player.find_child("StateMachine").current_state
	elif player != null && sm != null:
		smcs = player.find_child("StateMachine").current_state
		if self.state_name == smcs.state_name:
			#print("hhhhhhh" + state_name)
			player.get_node("QuiltCollider").disabled = false
			player.get_node("PhloCollider").disabled = true
			if smcs.state_name == "wall_jump":
				pass
			elif smcs.state_name != "cutscene" && smcs.state_name != "recoil":
				#print("AAAA" + smcs.state_name)
				move_dir = Input.get_axis("move_left","move_right")
				if move_dir !=0:
					player.velocity.x = move_dir * speed
				elif move_dir == 0:
					player.velocity.x = move_toward(player.velocity.x, 0, decceleration * _delta)
			if player.is_phlo:
				#if find_parent("StateMachine").current_state.state_name != "phlo_walk" || find_parent("StateMachine").current_state.state_name != "phlo_fall" || find_parent("StateMachine").current_state.state_name != "phlo_jump" || find_parent("StateMachine").current_state.state_name != "phlo_cutscene":
					#Transition.emit(self,"phlowalk")
				player.get_node("QuiltCollider").disabled = true
				player.get_node("PhloCollider").disabled = false
			pass
	

func _crouch_control():
	if Input.is_action_just_pressed("crouch"):
		player.scale.y = 4 * 0.75
	if Input.is_action_just_released("crouch"):
		player.scale.y = 4
	pass

func _force_leave_crouch():
	player.scale.y = 4

func _recoil_recharge_check():
	if player.is_on_floor():
		if not player.is_phlo:
			player.collected_objects = player.max_objects
