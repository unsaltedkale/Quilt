extends PlayerState
class_name Idle

@onready var anim = $"../../AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")

func _flip():
	anim.flip_h = not anim.flip_h

func move_left():
	if anim.flip_h:
		change_state.call_func("walk")
	else:
		_flip()

func move_right():
	if not anim.flip_h:
		change_state.call_func("walk")
	else:
		_flip()
