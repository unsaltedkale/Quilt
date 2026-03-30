extends Label

@export var type: message_type
@onready var ri = $"../Player/recoil_indicator"

enum message_type {movement, jump, recoil, interact}

var movement_message: Array[String]

var jump_message: Array[String]

var recoil_message: Array[String]

var interact_message: Array[String]

var super_array: Array[Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#KEYBOARD MOUSE = 0, CONTROLLER = 1
	
	movement_message = ["use [A] and [D] to move","use [LEFT JOYSTICK] or [D-PAD] to move"]
	jump_message = ["press [SPACEBAR] to jump","press [BOTTOM JOY PAD ACTION BUTTON] to jump"]
	recoil_message = ["click with [LEFT MOUSE CLICK] anywhere on screen to recoil","flick [RIGHT JOYSTICK] in any direction to recoil"]
	interact_message = ["press [E] to interact","press [LEFT JOY PAD ACTION BUTTON] to interact"]
	
	super_array = [movement_message,jump_message,recoil_message,interact_message]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var i
	
	if ri.controller == false:
		i = 0
	elif ri.controller == true:
		i = 1

	text = (str(super_array[type][i]))
	#print(text)
	
	pass
