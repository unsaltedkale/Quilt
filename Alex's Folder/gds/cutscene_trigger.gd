extends Area2D

@export var always_trigger: bool
@export var play_on_interact: bool
@export var container: cutscene_container
@export var current_event_index: int
@export var played: bool
@onready var player = $"../../Player"
@onready var Camera = $"../../Camera2D"
@onready var player_in_trigger: bool
@export var indicator: Node2D


func _ready() -> void:
	player_in_trigger = false

func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = true
		if indicator != null:
			indicator._open()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = false
		if indicator != null:
			indicator._close()

func _process(delta: float) -> void:
	if player_in_trigger && not played:
		if play_on_interact:
			if Input.is_action_just_pressed("interact"):
				_read_events()
				played = true
				if indicator != null:
					indicator._close()
		else:
			_read_events()
			played = true
			if indicator != null:
					indicator._close()
		
	pass

func _read_events():
	var tempvar = player.find_child("StateMachine").current_state
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
	tempvar = player.find_child("StateMachine").current_state
	tempvar.Transition.emit(tempvar, "fall")
