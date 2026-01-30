extends Node

@export var max_health: int = 1
var health: int


func _ready():
	health = max_health

func reduce_health(amount: int) -> void:
	health -= amount
	if health <= 0:
		return


	
