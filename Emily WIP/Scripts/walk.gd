extends State

signal play_footsteps()
signal stop_footsteps()

func Enter(previous_state: State):
	if player.crouch_speed == true:
		print("yus")
		walk_speed = 100
		_crouch_control()
	play_footsteps.emit()
	#print("walking")

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


func Physics_Update(_delta):
	_recoil_recharge_check()
	
	_crouch_control()
	if player.crouch_speed == true and walk_speed != 100:
		walk_speed = 100
	elif player.crouch_speed == false and walk_speed == 100:
		walk_speed = 800
	
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
	stop_footsteps.emit()
	#print("notwalk")
