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
	var actor_real
	
	if cutscene_trigger.get_tree().get_first_node_in_group("Req") != null:
	
		if str(actor).contains("Req"):
			print("AAAAA")
			actor_real = cutscene_trigger.get_node(str(actor))
		else:
			actor_real = cutscene_trigger.get_node(str(actor))
	
	else:
		print("click")
		if actor.get_name_count() != 0:
			actor = str(actor.get_name(actor.get_name_count() - 1))
		actor_real = cutscene_trigger.get_node("../../" + str(actor))
	
	print(actor_real)
	
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
	elif actor_real.get(variable_name) is int:
		print("INT")
		value = floor(value_float)
	elif actor_real.get(variable_name) is Node.ProcessMode:
		print("PROCESS NODE")
		value = floor(value_float)
		print(str(value))
	else:
		print("ERROR: VALUE TYPE NOT FOUND IN VARIABLE EVENT")
	actor_real.set_deferred(variable_name, value)
	pass
	
