extends Node

@export var max_health: int = 1
@onready var player_script: Player = get_parent() as Player

var health: int

func _ready():
	health = max_health
	

func reduce_health(amount: int) -> void:
	health -= amount
	if health <= 0:
		player_script.die()


	
