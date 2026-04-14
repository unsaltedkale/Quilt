extends Area2D

@onready var Conductor
@onready var Camera
@export var track: music_resource
@export var change_if_same_music_track: bool
@export var start_camera_pathing: bool = false
@export var vinyl_string: String

func _ready() -> void:
	if get_tree().root.get_child(0).find_child("Req") != null:
		Conductor = get_tree().root.get_child(0).find_child("Req").find_child("Conductor")
	else:
		Conductor = $"../../Conductor"
	
	if get_tree().root.get_child(0).find_child("Req") != null:
		Camera = get_tree().root.get_child(0).find_child("Req").find_child("Camera2D")
	else:
		Camera = $"../../Camera2D"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Conductor._change_music_track(track, change_if_same_music_track)
		if start_camera_pathing:
			Camera._path(vinyl_string)
