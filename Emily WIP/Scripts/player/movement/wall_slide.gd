extends State
@export var temp_acc: float

func Enter(_previous_state: State):
	if player.back_to_slide:
		temp_acc = player.stored_slide_acc + 3
		player.back_to_slide = false
	_force_leave_crouch()
	
	move_dir = Input.get_axis("move_left","move_right")
	if player.is_on_wall() and not player.is_on_floor():
		if move_dir != 0:
			player.wall_stick = true
		else:
			player.wall_stick = false
	if player.wall_stick:
		player.velocity.y += 50 * temp_acc
		temp_acc += 0.1
		if player.velocity.y > 300: # some numer
			player.velocity.y = 300
		#print("body hit wall")
	else:
		pass

func Physics_Update(_delta):
	if player.is_on_floor():
		player.stored_slide_acc = 0
		temp_acc = 0
	#THIS is how you get the wall direction?????? PAIN!!!!!!!
	#TODO: wall stick buffer timer, set, when exit wall slide, check for jump
	_change_state()

func _change_state():
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
	if Input.is_action_just_pressed("crouch"):
		player.stored_slide_acc = temp_acc
		Transition.emit(self, "wallcling")
