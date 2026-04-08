extends State

@export var gravity: float = 3000.0 #2000
@export var max_grav: float = 2000.0
var timer: float = 0.0

signal has_landed()
func Enter():
	timer = 0

func Exit():
	_recoil_recharge_check()

func Update(_delta):
	timer += 1
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
		print("timer",timer)
		if timer >= 5:
			if player.is_phlo:
				an.play("phlo_wump")
			else:
				an.play("land")
		else:
			if player.is_phlo:
				an.play("phlo_land")
			else:
				an.play("land")

func Physics_Update(_delta):
	if player.velocity.y <= max_grav:
		player.velocity.y += gravity * _delta
	else:
		player.velocity.y = max_grav
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.is_on_floor():
		player.velocity.x = 0
		Transition.emit(self, "idle")
		has_landed.emit() #signal to play landing sfx
		if not player.is_phlo:
			player.collected_objects = player.max_objects
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	if player.velocity.y >=0 and player.is_on_wall():
		Transition.emit(self, "wallstick")
	
	_crouch_control()
