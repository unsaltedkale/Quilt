class_name ProjectileComponent
extends Area2D

var speed = 900
var mouse = get_global_mouse_position()



func _physics_process(delta):
	position += transform.x * speed * delta
	
func shoot():
	var proj = $".".instantiate()
	proj.global_posision = $Marker2D
	owner.add_child(proj)
	proj.transform = mouse
