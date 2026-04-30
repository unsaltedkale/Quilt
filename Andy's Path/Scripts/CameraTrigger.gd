extends Node

@export var cameraOffset = 1
@export var targetZoom = 0.5
@export var zoomSpeed = 1

@onready var cameraRef = $"../Camera2D"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("change camera")
		targetZoom = 0.25

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("change camera")
		targetZoom = cameraRef.zoom.x

func _process(delta: float) -> void:
	cameraRef.zoom.x = lerp(cameraRef.zoom.x, targetZoom, delta*zoomSpeed)
	cameraRef.zoom.y = lerp(cameraRef.zoom.y, targetZoom, delta*zoomSpeed)
