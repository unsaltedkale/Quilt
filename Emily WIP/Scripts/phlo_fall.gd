extends State

@export var gravity: float = 3000.0 #2000
var fall_timer: float = 0

func Enter():
	fall_timer = 0

func Update(_delta):
	fall_timer += 20 * _delta
	if player.velocity.y >= 0:
		an.play("phlo_fall")
	if player.velocity.y < 0:
		an.play("phlo_jump")
	if player.is_on_floor():
		an.play("phlo_land")
		#phlo_wump when large fall

func Physics_Update(_delta):
	player.velocity.y += gravity * _delta
	if player.is_on_floor():
		print("phlo on floor")
		player.velocity.x = 0
		Transition.emit(self, "phlowalk")
