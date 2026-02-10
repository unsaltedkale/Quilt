@tool
extends cutscene_event
class_name animation_cutscene_event

@export var animator: NodePath
@export var animation_name: String
@export var horizontal_flip: bool


func execute(cutscene_trigger: Node) -> void:
	var animatorp = cutscene_trigger.get_node("../" + str(animator) + "/AnimatedSprite2D")
	
	animatorp.flip_h = horizontal_flip
	animatorp.set_flip_h(horizontal_flip)
	
	await animatorp.animation_finished
	
