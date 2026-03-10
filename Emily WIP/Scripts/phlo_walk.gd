extends PhloState

func Update(_delta):
	an.play("phlo_idle")
	
func Physics_Update(_delta):
	
	if !player.is_on_floor():
		Transition.emit(self, "phlofall")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "phlojump")
