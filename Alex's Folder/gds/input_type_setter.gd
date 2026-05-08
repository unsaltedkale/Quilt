extends Node

var PLAYER_DATA = preload("res://Resources/player_data.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_joy_connection_changed)
	if Input.get_connected_joypads() != []:
		#controller = true
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.controller
	else: 
		#controller = false
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.keyboard

func _joy_connection_changed(_device: int, _connected: bool):
	if Input.get_connected_joypads() != []:
		#controller = true
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.controller
	else: 
		#controller = false
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.keyboard

func _input(input_event : InputEvent) -> void: #Someone needs to check out this warning message, you shouldn't name a variable InputEvent.
	if input_event is InputEventKey || input_event is InputEventMouse:
		#controller = false
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.keyboard
	elif input_event is InputEventJoypadButton || input_event is InputEventJoypadMotion:
		#controller = true
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.controller

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#print(str(PLAYER_DATA.input_type.keys()[PLAYER_DATA.current_input_type]))
	
	if Input.is_action_just_pressed("fire_projectile") && PLAYER_DATA.current_input_type == PLAYER_DATA.input_type.controller:
		print("switched to mouse")
		#controller = false
		PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.keyboard
	elif Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if PLAYER_DATA.current_input_type == PLAYER_DATA.input_type.keyboard:
			print("switched to controller")
			#controller = true
			PLAYER_DATA.current_input_type = PLAYER_DATA.input_type.controller
