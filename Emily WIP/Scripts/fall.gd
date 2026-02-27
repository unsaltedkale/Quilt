extends State
class_name Fall

#@export var player: CharacterBody2D
@export var gravity: float = 3000.0 #2000

func Enter():
	pass

func Update(_delta):
	if player.velocity.y <0:
		$"../../AnimatedSprite2D".play("jump")
	if player.velocity.y >=0:
		$"../../AnimatedSprite2D".play("fall")
	if player.is_on_floor():
		$"../../AnimatedSprite2D".play("land")

func Physics_Update(_delta):
	player.velocity.y += gravity * _delta
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_on_floor():
		player.velocity.x = 0
		Transition.emit(self, "idle")
		player.collected_objects = player.max_objects
	if player.is_stasis:
		Transition.emit(self, "stasis")
