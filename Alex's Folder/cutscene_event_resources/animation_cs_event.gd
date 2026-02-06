@tool
extends cutscene_event
class_name animation_cutscene_event

@export var animator: NodePath
@export var animation_name: String


func execute(cutscene_trigger: Node) -> void:
	var animatorp = cutscene_trigger.get_node("../" + str(animator) + "/AnimatedSprite2D")
	
	animatorp.play(animation_name)
	
	await animatorp.animation_finished
	
