class_name ProjectileComponent
extends Area2D

var speed = 900

func _physics_process(delta):
	position += transform.x * speed * delta

'''func _on_ProjectileComponent_body_entered(body):
    if body.is_in_group(""):
        body.queue_free()
    queue_free()'''
