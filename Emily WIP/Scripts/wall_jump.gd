extends State
@export var jump_force_y: float
@export var actual_jump_force_y: float
@export var jump_force_x: int
var timer: float
var collision

func quilt_wall_jump():
	if not player.is_on_wall():
		player.velocity.y -= actual_jump_force_y
	else:
		player.velocity.y -= actual_jump_force_y / 3
	if collision.get_normal().x < 0:
		player.velocity.x -= jump_force_x
	elif collision.get_normal().x > 0:
		player.velocity.x += jump_force_x
	if player.is_phlo:
		an.play("phlo_jump")
	else:
		an.play("jump")

func Enter():
	timer = 12.0/60.0
	player.jump_count += 1
	actual_jump_force_y = jump_force_y - ( player.jump_count * 20)
	if actual_jump_force_y < 0:
		actual_jump_force_y = 0
	print(actual_jump_force_y)
	
	if player.get_slide_collision_count() != 0:
		for i in player.get_slide_collision_count():
			print(i)
			collision = player.get_slide_collision(i)
			'''print("Collided with: ", collision.get_collider().get_path())
			print("Collided with: ", collision.get_normal())
			'''
	quilt_wall_jump()
	print("jump count : ",player.jump_count)

func Physics_Update(_delta):
	if timer <= 0:
		#print_debug("click")
		Transition.emit(self,"fall")
	else:
		quilt_wall_jump()
		#print_debug("tap")
		timer -= _delta
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if player.collected_objects != 0:
			Transition.emit(self, "recoil")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")
	if player.is_on_floor():
		Transition.emit(self, "idle")
