extends State

@export var gravity: float = 3000.0 #2000
@export var max_grav: float = 2000.0

signal has_landed()

func Update(_delta):
	if player.velocity.y <0:
		an.play("jump")
	if player.velocity.y >=0:
		an.play("fall")
	if player.is_on_floor():
		an.play("land")
		has_landed.emit()
		#this code doesn't run when it should

func Physics_Update(_delta):
	if player.velocity.y <= max_grav:
		player.velocity.y += gravity * _delta
	else:
		player.velocity.y = max_grav
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_on_floor():
		player.velocity.x = 0
		Transition.emit(self, "idle")
		player.collected_objects = player.max_objects
	if player.is_stasis:
		Transition.emit(self, "stasis")
