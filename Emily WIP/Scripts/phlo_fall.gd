extends PhloState

@export var gravity: float = 3000.0 #2000

func Update(_delta):
	if player.velocity.y <0:
		an.play("phlo_jump")
	if player.velocity.y >=0:
		an.play("phlo_fall")
	if player.is_on_floor():
		an.play("phlo_land")
		#phlo_wump when large fall

func Physics_Update(_delta):
	player.velocity.y += gravity * _delta
	if player.is_on_floor():
		player.velocity.x = 0
		Transition.emit(self, "phlowalk")
