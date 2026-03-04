extends State
class_name Cutscene

# Called when the node enters the scene tree for the first time.

func Enter():
	player.velocity = Vector2(0,0)
	an.play("idle")
	print("entered cutscene state")
	
func Update(_delta):
	if not player.is_on_floor():
		an.play("fall")
	elif player.velocity.y > 0:
		an.play("jump")
	elif abs(player.velocity.x) > 0.01:
		an.play("walk")
	else:
		an.play("idle")
	pass
	
func Physics_Update(_delta):
	pass

	
