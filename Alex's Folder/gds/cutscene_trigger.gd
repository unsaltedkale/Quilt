extends Area2D

@export var always_trigger: bool
@export var container: cutscene_container
@export var current_event_index: int
@export var played: bool
@onready var Player = $"../Player"
@onready var Camera = $"../Camera2D"

func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	if not played:
		_read_events()
		played = true
	pass # Replace with function body.

func _read_events():
	var tempvar = Player.find_child("StateMachine").current_state
	var camera_zoom = Camera.zoom
	tempvar.Transition.emit(tempvar, "cutscene")
	for event in container.events:
		print_debug(event.resource_path)
		
		print_debug("HEY:" + str(event.delay_before))
		
		if event.delay_before > 0:
			print_debug("delay before timer started")
			await get_tree().create_timer(event.delay_before).timeout
			print_debug("delay before timer finished")
		
		print_debug("started event")
		
		await event.execute(self)
		
		print_debug("ended event")
		
		print_debug("HEY:" + str(event.delay_after))
		
		if event.delay_after > 0:
			print_debug("delay after timer started")
			await get_tree().create_timer(event.delay_after).timeout
			print_debug("delay after timer finished")
		
		print_debug("done!!!")
	print_debug("cutscene finished")
	played = true
	Camera.zoom = camera_zoom
	Camera.has_control = true
	tempvar = Player.find_child("StateMachine").current_state
	tempvar.Transition.emit(tempvar, "fall")
