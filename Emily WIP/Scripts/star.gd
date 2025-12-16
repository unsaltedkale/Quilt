extends Area2D
@export_subgroup("Settings")

func _on_STAR_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("collected a star")
		if body.collected_objects < body.max_stars:
			body.collected_objects += 1
		queue_free()
		
