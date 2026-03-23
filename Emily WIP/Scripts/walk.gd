extends State

signal play_footsteps()
signal stop_footsteps()

func quilt_walk():
	move_dir = Input.get_axis("move_left","move_right")
	player.velocity.x = move_dir * speed

func Enter():
	quilt_walk()
	play_footsteps.emit()
	#print("walking")

func _physics_process(delta: float) -> void:
	super(delta)

func Update(_delta):
	if player.is_phlo:
		an.play("phlo_idle")
	else:
		an.play("walk")

func Physics_Update(_delta):
	quilt_walk()
	if abs(move_dir) == 0:
		Transition.emit(self, "idle")
	if not player.is_on_floor():
		Transition.emit(self, "fall")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")

func Exit():
	stop_footsteps.emit()
	#print("notwalk")
