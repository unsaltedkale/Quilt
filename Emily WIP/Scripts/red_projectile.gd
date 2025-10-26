class_name ProjectileComponent
extends Area2D

var speed = 500
var projectile_direction

func _process(delta):
	position -= projectile_direction * speed * delta
	pass

func _on_projectile_body_entered(body):
	if (body is TileMapLayer):
		body.queue_free()
		queue_free()
	else:
		pass
