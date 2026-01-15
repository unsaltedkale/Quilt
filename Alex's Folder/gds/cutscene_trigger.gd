extends Area2D

@export var always_trigger: bool
@export var events_list: cutscene_container
@export var current_event_index: int

func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	_read_events()
	pass # Replace with function body.

func _read_events():
	for event in events_list:
		if event.delay_before > 0:
			await get_tree().create_timer(event.delay_before).timeout
		
		await event.execute(self)
		
		if event.delay_after > 0:
			await get_tree().create_timer(event.after).timeout
		pass
	pass
