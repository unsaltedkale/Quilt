extends AnimatedSprite2D

enum interact_type {TALK, READ}

@export var type = interact_type.TALK



func _ready() -> void:
	visible = false


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
