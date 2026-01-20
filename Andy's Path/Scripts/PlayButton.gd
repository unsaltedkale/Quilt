extends Control

func _ready() -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Alex's Folder/tscns/tutorial_1.tscn")


func _on_settings_pressed() -> void:
	print("Settings Pressed")
