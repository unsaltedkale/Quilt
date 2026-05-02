extends State

@export var walk_sfx : AudioStreamPlayer
@onready var walk_sfx_lag_timer : Timer = walk_sfx.get_child(0)

func Enter(_previous_state: State):
	if player.crouch_speed:
		#print("crouched")
		walk_speed = PLAYER_DATA.crouch_speed
		_crouch_control()
	if walk_sfx.get_playback_position() == 0: walk_sfx.play()
	else: walk_sfx.set_stream_paused(false)
	walk_sfx_lag_timer.stop()

func _physics_process(delta: float) -> void:
	super(delta)

func Update(_delta):
	if player.is_phlo:
		an.play("phlo_idle")
	else:
		if player.quilt_crouch.disabled == false:
			an.play("crouch_walk")
		else:
			an.play("walk")
	#Slows down walking sound effect when crouching
	walk_sfx.pitch_scale = (walk_speed / PLAYER_DATA.walk_speed) ** (1.0 / 3)


func Physics_Update(_delta):
	_recoil_recharge_check()
	
	_crouch_control()
	if player.crouch_speed == true and walk_speed != PLAYER_DATA.crouch_speed:
		walk_speed = PLAYER_DATA.crouch_speed
	elif player.crouch_speed == false and walk_speed != PLAYER_DATA.walk_speed:
		walk_speed = PLAYER_DATA.walk_speed
	
	if move_dir is int || move_dir is float:
		if abs(move_dir) == 0:
			Transition.emit(self, "idle")
	if not player.is_on_floor():
		Transition.emit(self, "fall")
	if Input.is_action_just_pressed("jump") && not player.force_crouch:
		Transition.emit(self, "jump")
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	
func Exit():
	walk_sfx_lag_timer.start()
	walk_sfx.volume_db = -5

func _on_footsteps_finished() -> void:
	walk_sfx.play()

func _on_timer_timeout() -> void:
	walk_sfx.volume_db = 0
	walk_sfx.set_stream_paused(true)
