extends Node2D

@export var state = "left"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var player_in_area: bool = false
signal changed(new_state)

func _ready() -> void:
	state = "left"

func _process(_delta) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
		_toggle_lever()
	
func _toggle_lever():
	if state == "right":
		state = "left"
		anim.play("lever_switch_to_left")
		print("lever: state=left")
		changed.emit(state)
		
	elif state == "left":
		state = "right" 
		anim.play("lever_switch_to_right")
		print("lever: state=right")
		changed.emit(state)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
