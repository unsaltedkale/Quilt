extends StaticBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		print("Breakable Wall Hit")
		_destroywall()
		


func _destroywall() -> void:
	queue_free()
