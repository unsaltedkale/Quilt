@tool
extends cutscene_event
class_name movement_cutscene_event

@export var mover: NodePath
@export var target: Vector2
@export var time: float
@export var is_relative: bool
@export var horizontal_flip: bool


func execute(cutscene_trigger: Node) -> void:
	var tween = cutscene_trigger.get_tree().create_tween()
	var moverp
	
	if cutscene_trigger.get_tree().root.get_child(0).find_child("Req") != null:
	
		moverp = cutscene_trigger.get_node(str(mover))
		
		print("mover: " + str(mover))
		
	elif cutscene_trigger.get_tree().root.get_child(0):
		pass
		# in container situaiton
	
	else:
		print("click")
		if mover.get_name_count() != 0:
			mover = str(mover.get_name(mover.get_name_count() - 1))
		moverp = cutscene_trigger.get_node("../../" + str(mover))
	
	#var animatorp = cutscene_trigger.get_node("../" + str(mover) + "/AnimatedSprite2D")
	# doesn't work -> animatorp.flip_h = horizontal_flip
	
	
	if is_relative:
		tween.tween_property(moverp, "position", target, time).as_relative()
	elif not is_relative:
		tween.tween_property(moverp, "position", target, time)
	if wait_until_done:
		await tween.finished
	
	
