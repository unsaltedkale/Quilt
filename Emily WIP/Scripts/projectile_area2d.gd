extends Area2D

func _on_projectile_body_entered(body): # has to be some kinematic body to queue or disable
	if body is CharacterBody2D:
		get_parent().queue_free()
	else:
		pass
