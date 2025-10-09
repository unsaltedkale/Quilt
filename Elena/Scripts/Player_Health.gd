extends Node

@export var max_health: int = 5
var health: int

func _ready():
	health = max_health

func reduce_health(amount: int) -> void:
	health -= amount
	print("Health: ", health)  
	if health <= 0:
		die()

func die():
	print("Player died")
	get_tree().reload_current_scene()
