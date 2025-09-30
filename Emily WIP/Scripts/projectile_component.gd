class_name ProjectileComponent
extends Area2D

@export_subgroup("Settings")
@export var mouse_component: MouseComponent

var speed = 900
'''
#func _physics_process(delta):
	#mouse_component.handle_movement(self, input_component.get_mouse_direction())

func shoot():
	var b = ProjectileComponent.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform'''
