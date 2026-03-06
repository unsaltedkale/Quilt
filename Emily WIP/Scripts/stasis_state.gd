extends State
class_name Stasis

@onready var stasis: Area2D = $"../../../Stasis"

func Enter():
	player.velocity = Vector2(0,0)

func Physics_Update(_delta):
	if Input.is_action_just_pressed("fire_projectile"):
		player.is_stasis = false
		Transition.emit(self, "recoil")
		stasis.timer = .5
	else:
		player.velocity = Vector2(0,0)
