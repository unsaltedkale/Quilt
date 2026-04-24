extends Node

@export var cameraOffset = 1
@export var cameraZoom = 1

func _on_body_entered(body: Node2D) -> void:
	if body.get_parent().is_in_group("Player"):
		print("change camera")
		$"../../Camera2D".zoom *= cameraZoom
		
