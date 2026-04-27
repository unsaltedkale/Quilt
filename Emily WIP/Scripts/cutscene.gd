extends State
class_name Cutscene

# Called when the node enters the scene tree for the first time.

@export var automatic_animations_frozen: bool
@export var prev_position: Vector2

func Enter(_previous_state: State):
	
	_force_leave_crouch()
	
	prev_position = get_parent().get_parent().position
	player.velocity = Vector2(0,0)
	if player.is_phlo:
		an.play("phlo_idle")
	else:
		an.play("idle")
	print("entered cutscene state")
	
func Update(_delta):
	player.velocity.x = 0
	if abs(prev_position.x - player.position.x) > 0.001:
		#print("click")
		if prev_position.x > player.position.x:
			player.find_child("AnimatedSprite2D").flip_h = true
			pass
		elif prev_position.x < player.position.x:
			player.find_child("AnimatedSprite2D").flip_h = false
			pass
		pass
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
	prev_position = get_parent().get_parent().position
	
func Physics_Update(_delta):
	pass




	
