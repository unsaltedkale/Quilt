extends State
class_name Stasis

#@export var player: CharacterBody2D
@onready var stasis: Area2D = $"../../Stasis"

func Enter():
	player.velocity = Vector2(0,0)

func Physics_Update(_delta):
	player.velocity = Vector2(0,0)
	player.is_stasis = true
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
		player.is_stasis = false
		stasis.timer = .5
