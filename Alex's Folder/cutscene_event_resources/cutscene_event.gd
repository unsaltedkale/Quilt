@tool
extends Resource
class_name cutscene_event

@export var delay_before: float
@export var delay_after: float
@export var wait_until_done: bool = true

func execute(_cutscene_trigger: Node) -> void:
	pass
