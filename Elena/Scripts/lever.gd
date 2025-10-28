extends Area2D

@export var state = "left"

func _ready() -> void:
	state = "left"

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and state == "right":
		state = "left"
		$AnimatedSprite.play("lever_switch_to_left")
		
	elif body.is_in_group("Player") and state == "left":
		state = "right" 
		$AnimatedSprite.play("lever_switch_to_right")
		
