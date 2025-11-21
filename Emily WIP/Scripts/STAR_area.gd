extends Area2D

func _on__body_entered(body: Node):
	if body is CharacterBody2D:
		get_parent().disabled = true
	else:
		pass
