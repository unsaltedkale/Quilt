extends Control

func _ready() -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Alex's Folder/tscns/pyra_intro_cutscene.tscn")


func _on_settings_pressed() -> void:
	print("Settings Pressed")
