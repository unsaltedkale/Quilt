extends Area2D

@export var always_trigger: bool
@export var play_on_interact: bool
@export var only_when_grounded: bool
@export var container: cutscene_container
@export var current_event_index: int
@export var played: bool
@onready var player
@onready var Camera
@onready var player_in_trigger: bool
@export var indicator: Node2D


func _ready() -> void:
	player_in_trigger = false
	if get_tree().root.get_child(0).find_child("Req") != null:
		player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
		Camera = get_tree().root.get_child(0).find_child("Req").find_child("Camera2D")
	else:
		player = $"../../Player"
		Camera = $"../../Camera2D"
	
func _on_area_entered(area: Area2D) -> void:
	# lock player movement
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = true
		if indicator != null:
			if always_trigger:
				if player.find_child("StateMachine").current_state != Cutscene:
					indicator._open()
			elif not always_trigger:
				if not played:
					indicator._open()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = false
		if indicator != null:
			if always_trigger:
				if player.find_child("StateMachine").current_state != Cutscene:
					indicator._close()
			elif not always_trigger:
				if not played:
					indicator._close()

func _process(delta: float) -> void:
	if player_in_trigger && not played:
		if play_on_interact && Input.is_action_just_pressed("interact"):
			if only_when_grounded && player.is_on_floor():
				_play()
			elif not only_when_grounded:
				_play()
		elif not play_on_interact:
			if only_when_grounded && player.is_on_floor():
				_play()
			elif not only_when_grounded:
				_play()
	elif player_in_trigger && played && always_trigger:
		if play_on_interact && Input.is_action_just_pressed("interact"):
			if only_when_grounded && player.is_on_floor():
				_play()
			elif not only_when_grounded:
				_play()
		'''elif not play_on_interact:
			if only_when_grounded && player.is_on_floor():
				_play()
			elif not only_when_grounded:
				_play()'''
		
	pass

func _play():
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
		print(event.resource_path)
		
		if event.delay_before > 0:
			await get_tree().create_timer(event.delay_before).timeout

		await event.execute(self)
		
		if event.delay_after > 0:
			await get_tree().create_timer(event.delay_after).timeout

	print_debug("cutscene finished")
	played = true
	var tween = get_tree().create_tween()
	tween.tween_property(Camera, "zoom", camera_zoom, 1)
	Camera.has_control = true
	tempvar = player.find_child("StateMachine").current_state
	tempvar.Transition.emit(tempvar, "fall")
	if get_parent().is_in_group("Vinyl"):
		get_parent().queue_free()
	
