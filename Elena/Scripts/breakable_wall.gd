extends StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		_timer()
		
		
func _timer() -> void:
	await get_tree().create_timer(.5).timeout
	print("Destroying Wall")
	get_parent().queue_free()
