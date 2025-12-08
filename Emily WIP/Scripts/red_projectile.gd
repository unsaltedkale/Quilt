extends Area2D

var speed = 500
var projectile_direction

func _process(delta):
	position += projectile_direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("Player"):
		queue_free()
	else:
		pass
