extends Node2D

var isInRange

func _on_area_2d_body_entered(body: Node2D) -> void:
	if isInRange:
		print("Hello") # Replace with function body.
