extends Node
class_name State

@export var player: CharacterBody2D
@export var speed: float = 600 #change 
@onready var an = $"../../AnimatedSprite2D"
var move_dir


signal Transition

func Enter():
	pass

func Exit():
	pass
	
func Update(_delta):
	pass


func _physics_process(delta: float) -> void:
	move_dir = Input.get_axis("move_left","move_right")
	player.velocity.x = move_dir * speed
	
func Physics_Update(_delta):
	pass
	
	#move_and_slide()
