extends StaticBody2D

@onready var timer: Timer 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		timer.start()
		
		
func _timer() -> void:
	await get_tree().create_timer(.5).timeout
	print("Destroying Falling Object")
	get_parent().queue_free()
