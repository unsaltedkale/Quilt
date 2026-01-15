@tool
extends Resource
class_name cutscene_event

@export var delay_before: float
@export var delay_after: float

func execute(cutscene_trigger: Node) -> void:
	pass
