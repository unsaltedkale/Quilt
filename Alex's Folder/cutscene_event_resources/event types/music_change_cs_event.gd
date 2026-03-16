@tool
extends cutscene_event
class_name music_change_cutscene_event

@export var conductor: NodePath
@export var music: music_resource


func execute(cutscene_trigger: Node) -> void:
	var conductor_real = cutscene_trigger.get_tree().get_nodes_in_group("Conductor")[0]
	conductor_real._change_music_track(music, false)
	
