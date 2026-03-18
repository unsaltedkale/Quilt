extends State
class_name Cutscene

# Called when the node enters the scene tree for the first time.

@export var automatic_animations_frozen: bool

func Enter():
	player.velocity = Vector2(0,0)
	an.play("idle")
	print("entered cutscene state")
	
func Update(_delta):
	if not automatic_animations_frozen:
		if not player.is_on_floor():
			if player.is_phlo:
				an.play("phlo_fall")
			else:
				an.play("fall")
		elif player.velocity.y > 0:
			if player.is_phlo:
				an.play("phlo_jump")
			else:
				an.play("jump")
		elif abs(player.velocity.x) > 0.01:
			if player.is_phlo:
				an.play("phlo_idle")
			else:
				an.play("walk")
		else:
			if player.is_phlo:
				an.play("phlo_idle")
			else:
				an.play("idle")
		pass
	
func Physics_Update(_delta):
	pass

	
