class_name ProjectileComponent
extends Node

@export var input_component: InputComponent

var mouse = 0

func shoot():
	var proj = $".".new()
	proj.global_posision = $Marker2D
	owner.add_child(proj)
	proj.transform = mouse
