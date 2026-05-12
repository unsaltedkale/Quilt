extends Node

@export var cameraOffsetX = 0.0

@export var cameraOffsetY = 0.0
@export var targetZoom = 0.5
@export var zoomSpeed = 1

@export var cameraRef: Node
@export var cameraTriggerIndex: int

@onready var inCameraTrigger = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inCameraTrigger = true
		cameraRef.currentCameraIndex = cameraTriggerIndex

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inCameraTrigger = false

func _process(delta: float) -> void:
	if inCameraTrigger == true:
		cameraRef.zoom.x = lerp(cameraRef.zoom.x, targetZoom, delta*zoomSpeed)
		cameraRef.zoom.y = lerp(cameraRef.zoom.y, targetZoom, delta*zoomSpeed)

		cameraRef.global_position.x = lerp(cameraRef.global_position.x, cameraOffsetX, delta*zoomSpeed)
		cameraRef.global_position.y = lerp(cameraRef.global_position.y, cameraOffsetY, delta*zoomSpeed)
	elif inCameraTrigger == false:
		cameraRef.zoom.x = lerp(cameraRef.zoom.x, 0.5, delta*zoomSpeed)
		cameraRef.zoom.y = lerp(cameraRef.zoom.y, 0.5, delta*zoomSpeed)
