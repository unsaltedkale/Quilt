extends AnimatedSprite2D

enum interact_type {TALK, READ}

@export var type = interact_type.TALK



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _open():
	visible = true
	if type == interact_type.TALK:
		play("open_talk")
	elif type == interact_type.READ:
		play("open_read")

func _close():
	visible = true
	if type == interact_type.TALK:
		play("close_talk")
	elif type == interact_type.READ:
		play("close_read")
