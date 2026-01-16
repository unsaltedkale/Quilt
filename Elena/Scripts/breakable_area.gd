extends Area2D

func _on_body_entered(body: Node2D):
	if body.is_in_group("Projectile"):
		var parent = self.get_parent()
		if parent:
			parent.modulate.a = 0
