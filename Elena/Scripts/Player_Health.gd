extends Node

@export var max_health: int = 1
@onready var Player = get_parent()
var spawn_point = Vector2.ZERO

var health: int

func _ready():
	health = max_health
	

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	
func die():
	print("Player died")
	spawn_player(spawn_point)
	
func set_checkpoint(pos):
	spawn_point = pos
	
func spawn_player(spawn_point: Vector2):
	Player.global_position = spawn_point
	Player.velocity = Vector2.ZERO
	health = max_health  


	
