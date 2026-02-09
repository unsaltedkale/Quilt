extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		var parent = self.get_parent()
		print("Projectile hit Breakable Wall")
		if parent:
			parent.queue_free()
