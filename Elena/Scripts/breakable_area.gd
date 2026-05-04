extends Area2D

var particles : Array[CPUParticles2D]

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Projectile"):
		var parent = self.get_parent()
		print("Projectile hit Breakable Wall")
		if parent:
			parent.queue_free()
			body.queue_free()
			for particle in particles: particle.queue_free()
