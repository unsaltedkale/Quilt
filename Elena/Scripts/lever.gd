extends Node2D

@export var state = "0"

func _ready():
	if state == "0":	
		$AnimatedSprite2D.play("lever_0") 
	else:
		$AnimatedSprite2D.play("lever_1")
		
func _procces():
	if $Area2D.overlaps_body("Player") and Input.is_action_just_pressed("use"):
		if state == "0":
			print("state 1")
			state == "1"
			$AnimatedSprite2D.play("lever_1")
		else: 
			print("state 0")
			state == "0"
			$AnimatedSprite2D.play("lever_0")
				
