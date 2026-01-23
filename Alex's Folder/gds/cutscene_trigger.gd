extends Area2D

@export var always_trigger: bool
@export var container: cutscene_container
@export var current_event_index: int
@export var played: bool
@onready var Player = $"../Player"
@onready var movement_compontent = $"../Player/MovementComponent"

func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	if not played:
		_read_events()
	pass # Replace with function body.

func _read_events():
	print("beep boop")
	Player.is_cutscene = true
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
	Player.is_cutscene = false
