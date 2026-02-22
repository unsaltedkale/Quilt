extends State
class_name Idle

@export var player: CharacterBody2D

var move_dir : Vector2

func idle_quilt():
	$"../../AnimatedSprite2D".play("idle")

func Enter():
	idle_quilt()
	player.velocity.x = 0
	player.velocity.y = 0
	print("idle")

func Physics_Update(_delta):
	idle_quilt()
	if absmove_dir
