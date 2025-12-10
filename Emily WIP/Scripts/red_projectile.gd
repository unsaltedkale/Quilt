extends Area2D

var speed : Vector2 = Vector2(-500,-500)
var projectile_direction

func _process(delta):
	$Sprite2D.play("FIRE")
	position += projectile_direction * speed * delta
	rotation = projectile_direction.angle() + 135

func _on_projectile_entered(body):
	if body is TileMap:
		queue_free()
	#if area.is_in_group("tilemap"):
		#queue_free()
	else:
		pass
