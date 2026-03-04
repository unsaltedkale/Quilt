extends Node
class_name State

@export var player: CharacterBody2D
@export var speed: float = 600  
@onready var an = $"../../AnimatedSprite2D"
var move_dir
var recoil:bool

signal Transition

func Enter():
	pass

func Exit():
	pass
	
func Update(_delta):
	pass

func _physics_process(_delta) -> void:
	print(recoil)
	if !recoil:
		move_dir = Input.get_axis("move_left","move_right")
		player.velocity.x = move_dir * speed
