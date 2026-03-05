@tool
extends cutscene_event
class_name animation_cutscene_event

@export var animator: NodePath
@export var animation_name: String
@export var horizontal_flip: bool


func execute(cutscene_trigger: Node) -> void:
	var animatorp = cutscene_trigger.get_node("../" + str(animator) + "/AnimatedSprite2D")
	
	print(animatorp.to_string() + "-------------------------------------------------")
	
	if animatorp.find_parent("Player") != null:
		if animatorp.find_parent("Player").is_in_group("Player"):
			animatorp.find_parent("Player").find_child("StateMachine").find_child("Cutscene").automatic_animations_frozen = true
	
	animatorp.play(animation_name)
	
	await animatorp.animation_finished
	
	if animatorp.find_parent("Player") != null:
		if animatorp.find_parent("Player").is_in_group("player"):
			animatorp.find_parent("Player").automatic_animations_frozen = false
	
