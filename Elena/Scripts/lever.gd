extends Area2D

@export var state = "left"
@onready var anim: AnimatedSprite2D = $"../AnimatedSprite2D"

signal state_change(new_state: String)

func _ready() -> void:
	state = "left"

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return 
		
	if state == "right":
		state = "left"
		anim.play("lever_switch_to_left")
		
	elif state == "left":
		state = "right" 
		anim.play("lever_switch_to_right")
		
	emit_signal("state_change", state)
