extends Node

@export var max_health: int = 1
var health: int

@onready var player := get_parent() as Node2D

func _ready():
	health = max_health

func reduce_health(amount: int) -> void:
	health -= amount
	print("Health: ", health)  
	if health <= 0:
		die()

func die():
	print("Player died")
	GameManager.respawn_player(player)
