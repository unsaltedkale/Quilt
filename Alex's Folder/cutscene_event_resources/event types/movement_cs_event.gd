@tool
extends cutscene_event
class_name movement_cutscene_event

@export var mover: NodePath
@export var target: Vector2
@export var time: float
@export var is_relative: bool
@export var horizontal_flip: bool

var req = preload("res://Alex's Folder/gds/req.gd")


func execute(cutscene_trigger: Node) -> void:
	var tween = cutscene_trigger.get_tree().create_tween()
	var moverp
	
	if cutscene_trigger.get_tree().get_first_node_in_group("Req") != null:
		if cutscene_trigger.get_tree().get_first_node_in_group("Req").a == req.req_type.staging:
		
			print("staging")
			
			moverp = cutscene_trigger.get_node(str(mover))
			
			print("mover: " + str(mover))
			
		elif cutscene_trigger.get_tree().get_first_node_in_group("Req").a == req.req_type.prod:
			
			print("prod")
			
			
			moverp = cutscene_trigger.get_node(str(mover))
			
			pass
	
	else:
		print("click")
		if mover.get_name_count() != 0:
			mover = str(mover.get_name(mover.get_name_count() - 1))
		moverp = cutscene_trigger.get_node("../../" + str(mover))
	
	#var animatorp = cutscene_trigger.get_node("../" + str(mover) + "/AnimatedSprite2D")
	# doesn't work -> animatorp.flip_h = horizontal_flip
	
	
	if is_relative:
		tween.tween_property(moverp, "global_position", target, time).as_relative()
	elif not is_relative:
		target += cutscene_trigger.get_parent().get_parent().global_position
		tween.tween_property(moverp, "global_position", target, time)
	if wait_until_done:
		await tween.finished
	
	
