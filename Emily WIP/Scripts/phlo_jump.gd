extends PhloState

@export var jump_velocity: float = -750.0 #change
var timer : float = 7.0

func phlo_jump():
	if player.is_on_floor():
			player.velocity.y = jump_velocity
			an.play("phlo_jump")

func Enter():
	timer = 7
	phlo_jump()

func Physics_Update(_delta):
	if timer <= 0:
		Transition.emit(self,"phlofall")
	else:
		phlo_jump()
		timer -= 1
