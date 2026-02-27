@tool
extends cutscene_event
class_name dialouge_cutscene_event

@export var dia: Resource


func execute(cutscene_trigger: Node) -> void:
	#place holder
	
	var button = cutscene_trigger.get_tree().get_first_node_in_group("Dialouge_Button") 
	
	button.Dialogue(dia.resource_path)
	
	await button.dialouge_finished
	
	print("dialouge here")
	pass
	
