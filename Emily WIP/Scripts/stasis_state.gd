extends State
class_name Stasis


func Enter(previous_state: State):
	player.velocity = Vector2(0,0)

func Physics_Update(_delta):
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		player.current_stasis = null
		Transition.emit(self, "recoil")
	#Elliot wanted this, might delete later --Alex
	elif Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("crouch"):
			player.current_stasis = null
			Transition.emit(self, "idle")
		else:
			player.current_stasis = null
			Transition.emit(self, "jump")
	else:
		player.velocity = Vector2(0,0)
