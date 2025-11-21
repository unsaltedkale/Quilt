extends Area2D

@onready var Conductor = $"../Conductor"
@export var track: music_resource

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Conductor._change_music_track(track)
