extends State
'''
func Enter(_previous_state: State):
	_force_leave_crouch()
	move_dir = Input.get_axis("move_left","move_right")
	
	if player.is_on_wall() and not player.is_on_floor():
		if move_dir != 0:
			player.wall_stick = true
		else:
			player.wall_stick = false
	if player.wall_stick:
		player.velocity.y += 50 * PLAYER_DATA.temp_acc
		PLAYER_DATA.temp_acc += 0.1
		if player.velocity.y > 300: # some numer
			player.velocity.y = 300
	else:
		Transition.emit(self, "wallstick")

func Physics_Update(_delta):
	_change_state()

func _change_state():
	if not player.is_on_wall() and not player.is_on_floor():
		player.wall_stick = false
		Transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"):
		player.wall_stick = false
		Transition.emit(self, "walljump")
	move_dir = Input.get_axis("move_left","move_right")
	if move_dir == 0 and not player.is_on_floor():
		player.wall_stick = false
		Transition.emit(self, "fall")
	if move_dir == 0 and player.is_on_floor():
		player.wall_stick = false
		Transition.emit(self, "idle")
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
'''
