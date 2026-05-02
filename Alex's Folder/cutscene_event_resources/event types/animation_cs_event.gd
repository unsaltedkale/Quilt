@tool
extends cutscene_event
class_name animation_cutscene_event

@export var animator: NodePath
@export var animation_name: String
@export var horizontal_flip: bool

var req = preload("res://Alex's Folder/gds/req.gd")

func execute(cutscene_trigger: Node) -> void:
	
	var animatorp
	
	if cutscene_trigger.get_tree().get_first_node_in_group("Req") != null:
	
		if cutscene_trigger.get_tree().get_first_node_in_group("Req").a == req.req_type.staging:
		
			print("staging")
			
			animatorp = cutscene_trigger.get_node(str(animator))
			
			if animatorp is not AnimatedSprite2D:
				animatorp = cutscene_trigger.get_node(str(animator) + "/AnimatedSprite2D")
			
		elif cutscene_trigger.get_tree().get_first_node_in_group("Req").a == req.req_type.prod:
			
			print("prod")
			
			if str(animatorp).contains("Req"):
				animatorp = cutscene_trigger.get_node("../" + str(animator))
			
			else:
				animatorp = cutscene_trigger.get_node(str(animator))
			
			if animatorp is not AnimatedSprite2D:
				animatorp = cutscene_trigger.get_node(str(animator) + "/AnimatedSprite2D")
			
			pass
	
	else:
		print("click")
		if animator.get_name_count() != 0:
			animator = str(animator.get_name(animator.get_name_count() - 1))
		
		animatorp = cutscene_trigger.get_node("../../" + str(animator))
		
		if animatorp is not AnimatedSprite2D:
			animatorp = cutscene_trigger.get_node("../../" + str(animator) + "/AnimatedSprite2D")
	
	print(animatorp.to_string() + "-------------------------------------------------")
	
	if animatorp.find_parent("Player") != null:
		if animatorp.find_parent("Player").is_in_group("Player"):
			animatorp.find_parent("Player").find_child("StateMachine").find_child("Cutscene").automatic_animations_frozen = true
	
	animatorp.play(animation_name)
	
	if wait_until_done:
		await animatorp.animation_finished
	
	if animatorp.find_parent("Player") != null:
		if animatorp.find_parent("Player").is_in_group("player"):
			animatorp.find_parent("Player").automatic_animations_frozen = false
	
