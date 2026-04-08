extends State

@export var jump_velocity: float = -950.0 #change
var timer : float = 7.0

signal jump_sound()

func quilt_jump():
	if player.is_on_floor():
		player.velocity.y = jump_velocity
		if player.is_phlo:
			an.play("phlo_jump")
		else:
			an.play("jump")

func Enter():
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
