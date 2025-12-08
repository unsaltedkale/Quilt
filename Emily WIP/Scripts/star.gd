extends Area2D

func _on_STAR_body_entered(body: Node2D) -> void:
	print("collided")
	if body.is_in_group("Player"):
		queue_free()
	else:
		print("not player")
