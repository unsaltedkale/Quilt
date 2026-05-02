@tool
extends cutscene_event
class_name change_scene_cutscene_event

@export var scene_path: String

#need an object in the scene to change the scene. most times make this the player.
@export var rock: NodePath


func execute(cutscene_trigger: Node) -> void:
	#place holder
	
	#var rockp = cutscene_trigger.get_node("../../" + str(rock))
	
	cutscene_trigger.get_tree().call_deferred("change_scene_to_file", scene_path)
	pass
	
