extends State

var fall_timer: float = 0.0
var time_since_last_jump_press: float = -5000

var walking_last_state: bool = false

signal has_landed()
func Enter(previous_state: State):
	time_since_last_jump_press = -5000000000000000
	if previous_state.state_name == "walk":
		walking_last_state = true
	else:
		walking_last_state = false
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
	if player.is_on_floor():
		land()

func land():
	if fall_timer >= .9:
		if player.is_phlo:
			an.play("phlo_mini_wump")
		else:
			an.play("land")
	else:
		if player.is_phlo:
			an.play("phlo_land")
		else:
			an.play("land")

func Physics_Update(_delta):
	if Input.is_action_just_pressed("jump"):
		time_since_last_jump_press = fall_timer
	
	if walking_last_state:
		if PLAYER_DATA.cayote_time >= fall_timer and Input.is_action_just_pressed("jump"):
			Transition.emit(self, "jump")
			walking_last_state = false
	if player.velocity.y <= PLAYER_DATA.max_fall_vel:
		player.velocity.y += PLAYER_DATA.grav_accel * _delta
	else:
		player.velocity.y = PLAYER_DATA.max_fall_vel
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.is_on_floor():
		player.velocity.x = 0
		land()
		if fall_timer - time_since_last_jump_press <= PLAYER_DATA.jump_buffer_time:
			Transition.emit(self, "jump")

		Transition.emit(self, "idle")
		has_landed.emit() #signal to play landing sfx
		if not player.is_phlo:
			player.collected_objects = player.max_objects
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	if player.velocity.y >=0 and player.is_on_wall():
		Transition.emit(self, "wallstick")
	
	_crouch_control()

func _on_animation_finished():
	var anim = str($"../../AnimatedSprite2D".animation)
	if anim == "phlo_mini_wump" or "phlo_land":
		Transition.emit(self, "idle")
	elif anim == "land":
		Transition.emit(self, "idle")
