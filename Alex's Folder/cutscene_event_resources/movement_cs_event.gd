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
	var moverp = cutscene_trigger.get_node("../" + str(mover))
	var animatorp = cutscene_trigger.get_node("../" + str(mover) + "/AnimatedSprite2D")
	# doesn't work -> animatorp.flip_h = horizontal_flip
	if is_relative:
		tween.tween_property(moverp, "position", target, time).as_relative()
	elif not is_relative:
		tween.tween_property(moverp, "position", target, time)
	await tween.finished
	
	
