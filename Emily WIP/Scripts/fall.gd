extends State

@export var gravity: float = 3000.0 #2000
@export var max_grav: float = 2000.0

signal has_landed()

func Update(_delta):
	if player.velocity.y <0:
		if player.is_phlo:
			an.play("phlo_jump")
		else:
			an.play("jump")
	if player.velocity.y >=0:
		if player.is_phlo:
			an.play("phlo_fall")
		else:
			an.play("fall")
	if player.is_on_floor():
		if player.is_phlo:
			an.play("phlo_land")
		else:
			an.play("land")

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
		has_landed.emit() #signal to play landing sfx
		if not player.is_phlo:
			player.collected_objects = player.max_objects
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
