extends State
class_name Jump

#@export var player: CharacterBody2D
@export var jump_velocity: float = -950.0 #change
var timer : float = 7.0

func quilt_jump():
	if player.is_on_floor():
		player.velocity.y = jump_velocity
		$"../../AnimatedSprite2D".play("jump")

func Enter():
	timer = 7
	quilt_jump()

func Physics_Update(_delta):
	if timer <= 0:
		Transition.emit(self,"fall")
	else:
		quilt_jump()
		timer -= 1
		print(timer)
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_stasis:
		Transition.emit(self, "stasis")

func Exit():
	pass
