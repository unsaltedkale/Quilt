extends Area2D

var speed = 900

func _physics_process(_float):
	position += transform.x * speed
