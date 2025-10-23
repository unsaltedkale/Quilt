class_name ProjectileComponent
extends Area2D

var speed = .05

func _physics_process(delta):
	#go to mouse location
	position.x += get_viewport().get_mouse_position().x * speed
	#print("projectile position x: ", position.x)
	position.y += get_viewport().get_mouse_position().y * speed 
	#print("projectile position y: ", position.y)

func _on_projectile_body_entered(body):
	if (body is TileMapLayer):
		body.queue_free()
		queue_free()
