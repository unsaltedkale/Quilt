class_name ProjectileComponent
extends RigidBody2D

var speed = 500
var projectile_direction 

func _process(delta):
	position -= projectile_direction * speed * delta
	pass
