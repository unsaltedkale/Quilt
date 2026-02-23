extends State
class_name Idle

@export var player: CharacterBody2D

func idle_quilt():
	$"../../AnimatedSprite2D".play("idle")

func Enter():
	idle_quilt()

func Physics_Update(_delta):
	idle_quilt()
	var move_dir = Input.get_axis("move_left","move_right")
	if abs(move_dir) > 0:
		Transition.emit(self, "walk")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
	if not player.is_on_floor():
		Transition.emit(self, "fall")
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_stasis:
		Transition.emit(self, "stasis")

func Exit():
	pass
