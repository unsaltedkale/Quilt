extends Area2D

@export var always_trigger: bool
@export var container: cutscene_container
@export var current_event_index: int
@export var played: bool
@onready var Player = $"../Player"

func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	print("boop beep")
	if not played:
		_read_events()
	pass # Replace with function body.

func _read_events():
	print("beep boop")
	Player.find_child("StateMachine").find_child("Cutscene").Transition.emit(Player.find_child("StateMachine").find_child("Cutscene"), "cutscene")
	for event in container.events:
		if event.delay_before > 0:
			await get_tree().create_timer(event.delay_before).timeout
			print("start time done")
		print("start events")
		await event.execute(self)
		
		if event.delay_after > 0:
			await get_tree().create_timer(event.delay_after).timeout
		print("done!!!")
	played = true
	Player.find_child("StateMachine").find_child("Idle").Transition.emit(Player, "idle")
