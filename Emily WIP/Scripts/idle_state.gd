extends State
class_name Idle

func idle_quilt():
	if player.is_phlo:
		an.play("phlo_idle")
	else:
		an.play("idle")

func Enter():
	idle_quilt()

func Physics_Update(_delta):
	idle_quilt()
	move_dir = Input.get_axis("move_left","move_right")
	if abs(move_dir) > 0:
		Transition.emit(self, "walk")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
	if not player.is_on_floor():
		Transition.emit(self, "fall")
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			print("recoil state")
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
