extends State

func phlo_walk():
	move_dir = Input.get_axis("move_left","move_right")
	player.velocity.x = move_dir * speed

func Update(_delta):
	an.play("phlo_idle")
	
func Physics_Update(_delta):
	phlo_walk()
	if !player.is_on_floor():
		Transition.emit(self, "phlofall")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "phlojump")
