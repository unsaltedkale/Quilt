extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.collected_objects += 1 
		queue_free()
		print("Collected Objects: ", body.collected_objects)
