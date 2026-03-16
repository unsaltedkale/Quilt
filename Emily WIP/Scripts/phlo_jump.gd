extends State

@export var phlo_jump_vel: float = -750.0 #change
var timer : float = 7.0

func phlo_jump():
	if player.is_on_floor():
		player.velocity.y = phlo_jump_vel
		an.play("phlo_jump")

func Enter():
	timer = 7
	phlo_jump()

func _physics_process(_delta) -> void:
	Physics_Update(_delta)
func Physics_Update(_delta):
	if timer <= 0:
		Transition.emit(self,"phlofall")
	else:
		phlo_jump()
		timer -= 1
