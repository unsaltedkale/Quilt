extends Area2D
@onready var player = $"../../Player"

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.is_magical_wall = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.is_magical_wall = false
