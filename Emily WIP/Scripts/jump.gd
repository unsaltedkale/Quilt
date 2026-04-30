extends State

var timer : float = 7.0

signal jump_sound()

func quilt_jump():
	if player.quilt_crouch.disabled == false:
		player.velocity.y = PLAYER_DATA.crouch_jump_vel
	else:
		player.velocity.y = PLAYER_DATA.jump_vel
	if player.is_phlo:
		an.play("phlo_jump")
	else:
		if player.quilt_crouch.disabled == false:
			an.play("crouch_idle")
		else:
			an.play("jump")

func Enter(_previous_state: State):
	_recoil_recharge_check()
	player.jump_count += 1
	timer = 7
	quilt_jump()
	#TODO: ADD JUMP SFX
	jump_sound.emit()

func Physics_Update(_delta):
	if timer <= 0:
		Transition.emit(self,"fall")
	else:
		quilt_jump()
		timer -= 1
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	
	_crouch_control()

func Exit():
	pass
