extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.shrine_key = true
		queue_free()
		print("You have picked up a Shrine Key")
