extends State
class_name PhloState

func _physics_process(_delta) -> void:
	move_dir = Input.get_axis("move_left","move_right")
	if move_dir !=0:
		player.velocity.x = move_dir * speed
	if !player.is_phlo:
		Transition.emit(self, "idle")
	else:
		Transition.emit(self, "phlowalk")
	pass
