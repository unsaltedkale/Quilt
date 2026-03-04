@tool
extends cutscene_event
class_name set_variable_cutscene_event

@export var actor: NodePath
@export var variable_name: String
@export var value_bool: bool
@export var value_string: String
@export var value_float: float
@export var value_vector2: Vector2


func execute(cutscene_trigger: Node) -> void:
	#place holder
	var actor_real = cutscene_trigger.get_node("../" + str(actor))
	var value
	if actor_real.get(variable_name) is bool:
		value = value_bool
		pass
	elif actor_real.get(variable_name) is String:
		value = value_string
		pass
	elif actor_real.get(variable_name) is float:
		value = value_float
		pass
	elif actor_real.get(variable_name) is Vector2:
		value = value_vector2
		pass
	actor_real.set_deferred(variable_name, value)
	pass
	
