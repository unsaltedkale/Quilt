extends State
class_name Stasis


func Enter():
	player.velocity = Vector2(0,0)

func Physics_Update(_delta):
	if Input.is_action_just_pressed("fire_projectile"):
		player.current_stasis = null
		Transition.emit(self, "recoil")
	else:
		player.velocity = Vector2(0,0)
