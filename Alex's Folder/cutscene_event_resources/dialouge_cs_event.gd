@tool
extends cutscene_event
class_name dialouge_cutscene_event

@export var dia: DialogResource


func execute(cutscene_trigger: Node) -> void:
	#place holder
	
	var button = cutscene_trigger.get_tree().get_nodes_in_group("Conductor")[0]  
	
	button.Dialouge(dia)
	
	await button.dialouge_finished
	
	print("dialouge here")
	pass
	
