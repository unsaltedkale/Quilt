extends Node
class_name State

@export var player: CharacterBody2D
@export var speed: float = 800
@onready var an = $"../../AnimatedSprite2D"
var move_dir
var recoil: bool
var cutscene: bool

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
	if !recoil || !cutscene:
		move_dir = Input.get_axis("move_left","move_right")
		if move_dir !=0:
			player.velocity.x = move_dir * speed
	if player.is_phlo:
		player.get_node("QuiltCollider").disabled = true
		player.get_node("PhloCollider").disabled = false
		Transition.emit(self,"phlowalk")
	pass
