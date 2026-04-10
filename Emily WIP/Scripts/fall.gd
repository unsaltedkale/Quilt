extends State

@export var gravity: float = 3000.0 #2000
@export var max_grav: float = 2000.0
var fall_timer: float = 0.0

signal has_landed()
func Enter():
	fall_timer = 0

func Exit():
	_recoil_recharge_check()

func Update(_delta):
	fall_timer += _delta
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

func land():
	if fall_timer >= 1:
		if player.is_phlo:
			an.play("phlo_wump")
			#await an.animation_finished
			an.play("phlo_idle")
		else:
			pass
	else:
		if player.is_phlo:
			an.play("phlo_land")
			#await an.animation_finsihed
			an.play("phlo_idle")
		else:
			an.play("land")
			#await an.animation_finsihed
			an.play("idle")
	

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
		land()
		Transition.emit(self, "idle")
		has_landed.emit() #signal to play landing sfx
		if not player.is_phlo:
			player.collected_objects = player.max_objects
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	if player.velocity.y >=0 and player.is_on_wall():
		Transition.emit(self, "wallstick")
	
	_crouch_control()
