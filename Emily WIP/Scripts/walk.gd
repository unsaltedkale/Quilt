extends State
class_name Walk

@export var player: CharacterBody2D
@export var speed: float = 600 #change 
var move_dir

func quilt_walk():
	move_dir = Input.get_axis("move_left","move_right")
	player.velocity.x = move_dir * speed

func Enter():
	quilt_walk()

func Physics_Update(_delta):
	quilt_walk()
	if abs(move_dir) == 0:
		Transition.emit(self, "idle")
	if not player.is_on_floor():
		Transition.emit(self, "fall")
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
	if Input.is_action_just_pressed("fire_projectile") and player.collected_objects != 0:
		Transition.emit(self, "recoil")
	if player.is_stasis:
		Transition.emit(self, "stasis")

func Exit():
	pass
