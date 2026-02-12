@tool
extends cutscene_event
class_name dialouge_cutscene_event

@export var animator: NodePath
@export var animation_name: String
@export var horizontal_flip: bool


func execute(cutscene_trigger: Node) -> void:
	#place holder
	print("dialouge here")
	pass
	
