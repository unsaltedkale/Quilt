@tool
extends cutscene_event
class_name camera_cutscene_event

@export var camera: NodePath

@export var change_position: bool
@export var position: Vector2
@export var position_is_relative: bool

@export var change_zoom: bool
@export var zoom: Vector2
@export var zoom_is_relative: bool

@export var time: float

@export var unlock_camera_at_end: bool


func execute(cutscene_trigger: Node) -> void:
	var tween = cutscene_trigger.get_tree().create_tween()
	var camerap = cutscene_trigger.get_node("../" + str(camera))
	
	camerap.has_control = false
	
	# doesn't work -> animatorp.flip_h = horizontal_flip
	if change_position && position_is_relative:
			tween.tween_property(camerap, "position", position, time).as_relative()
	if change_zoom && zoom_is_relative:	
		tween.tween_property(camerap, "zoom", zoom, time).as_relative()
	if change_position && not position_is_relative:
		tween.tween_property(camerap, "position", position, time)
	if change_zoom && not zoom_is_relative:	
		tween.tween_property(camerap, "zoom", zoom, time)
	
	if change_zoom || change_position:
		print("awaiting")
		await tween.finished
	
	if unlock_camera_at_end:
		camerap.has_control = true
