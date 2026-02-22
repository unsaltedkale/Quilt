extends State
class_name Fall

@export var player: CharacterBody2D
@export var gravity: float = 3000.0 #2000

func Physics_Update(_delta):
	player.velocity.y += gravity * _delta
	$"../../AnimatedSprite2D".play("fall")
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_on_floor():
		$"../../AnimatedSprite2D".play("land")
		player.velocity.x = 0
		Transition.emit(self, "idle")
