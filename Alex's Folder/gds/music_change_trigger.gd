extends Area2D

@onready var Conductor = $"../../Conductor"
@export var track: music_resource
@export var change_if_same_music_track: bool
@export var start_camera_pathing: bool = false
@export var vinyl_string: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Conductor._change_music_track(track, change_if_same_music_track)
		if start_camera_pathing:
			$"../../Camera2D"._path(vinyl_string)
