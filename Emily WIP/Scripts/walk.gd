extends State
class_name Walk

@export var player: CharacterBody2D
@export var speed: float = 600 #change 

var move_dir : float = Input.get_axis("move_left","move_right")

func quilt_walk():
	player.velocity.x = move_dir * speed

func Enter():
	quilt_walk()

func Physics_Update(_delta):
	quilt_walk()
	if abs(move_dir) == 0:
		Transition.emit(self, "idle")
