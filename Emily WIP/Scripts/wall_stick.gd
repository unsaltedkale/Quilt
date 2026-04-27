extends State
var wall_stick :bool

@export var temp_acc: float

func Enter(_previous_state: State):
	
	_force_leave_crouch()
	
	move_dir = Input.get_axis("move_left","move_right")
	if player.is_on_wall() and not player.is_on_floor():
		if move_dir != 0:
			wall_stick = true
		else:
			wall_stick = false
	if wall_stick:
		player.velocity.y += 50 * temp_acc
		temp_acc += 0.1
		if player.velocity.y > 300: # some numer
			player.velocity.y = 300
		#print("body hit wall")
	else:
		pass

func Physics_Update(_delta):
	
	#THIS is how you get the wall direction?????? PAIN!!!!!!!
	
	
	
	# wall cling storage fix:
	if not player.is_on_wall() and not player.is_on_floor():
		wall_stick = false
		Transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"):
		wall_stick = false
		Transition.emit(self, "walljump")
	move_dir = Input.get_axis("move_left","move_right")
	if move_dir == 0 and not player.is_on_floor():
		wall_stick = false
		Transition.emit(self, "fall")
	if move_dir == 0 and player.is_on_floor():
		wall_stick = false
		Transition.emit(self, "idle")
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	
