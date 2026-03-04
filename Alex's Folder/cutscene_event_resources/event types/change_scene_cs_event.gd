@tool
extends cutscene_event
class_name change_scene_cutscene_event

@export var scene_path: String


func execute(cutscene_trigger: Node) -> void:
	#place holder
	cutscene_trigger.get_tree().change_scene_to_file("res://Alex's Folder/tscns/pyra_intro_cutscene.tscn")
	pass
	
