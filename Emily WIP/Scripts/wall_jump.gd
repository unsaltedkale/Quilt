extends State
@export var jump_force_y: float
@export var jump_force_x: int
var timer: float

func quilt_wall_jump():
	if not player.is_on_wall():
		player.velocity.y -= jump_force_y
	else:
		player.velocity.y -= jump_force_y / 3
	player.velocity.x += jump_force_x
	if player.is_phlo:
		an.play("phlo_jump")
	else:
		an.play("jump")

func Enter():
	timer = 12
	quilt_wall_jump()

func Physics_Update(_delta):
	
	if timer <= 0:
		#print_debug("click")
		Transition.emit(self,"fall")
	else:
		quilt_wall_jump()
		#print_debug("tap")
		timer -= 1
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
