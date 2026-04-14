extends RichTextLabel

@export var type: message_type
@onready var ri

enum message_type {movement, jump, recoil, interact, reset_point, dialouge_continue}

var movement_message: Array[String]

var jump_message: Array[String]

var recoil_message: Array[String]

var interact_message: Array[String]

var resetpoint_message: Array[String]

var dialouge_continue_message: Array[String]

var super_array: Array[Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if get_parent().name == "DialogueScreen":
		ri = $"../../../../../Player/recoil_indicator"
	else:
		ri = $"../Player/recoil_indicator"
	
	#KEYBOARD MOUSE = 0, CONTROLLER = 1
	
	movement_message = ["use {06} to move","use {05} or {08} to move"]
	jump_message = ["press {12} to jump","press {14} to jump"]
	recoil_message = ["click with {24} anywhere on screen to recoil","flick {26} in any direction to recoil"]
	interact_message = ["press {22} to interact","press {20} to interact"]
	resetpoint_message = ["hold {22} at a resetpoint to reset", "hold {20} at a reset point to reset"]
	dialouge_continue_message = ["{22}","{20}"]
	
	
	super_array = [movement_message,jump_message,recoil_message,interact_message,resetpoint_message,dialouge_continue_message]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var i
	if ri != null:
		if ri.controller == false:
			i = 0
		elif ri.controller == true:
			i = 1
		
		var l = (str(super_array[type][i]))
		
		while l.contains("{"):
			var start = l.find("{")
			
			var end = l.find("}", start + 1)
			
			var pic = l.substr(start, end - start + 1)
			
			var picClean = pic.replace("{", "")
			
			picClean = picClean.replace("}", "")
			
			#[img=64]res://Art/Tool Tips/ttm_20.png[/img]
			
			#if animation not found throw error and play empty 
			if load("res://Art/Tool Tips/ttm_" + picClean + ".png") != null:
				l = l.replace("{" + picClean +  "}", "[img=96]res://Art/Tool Tips/ttm_" + picClean + ".png[/img]")
			else:
				print_debug("ERROR: Image for text not found. Name: " + picClean)
			
			if get_parent().name == "DialogueScreen":
				l = l.replace("96", "64")
			
		text = l
		#print(text)
	else:
		if get_tree().get_first_node_in_group("player") != null:
			ri = get_tree().get_first_node_in_group("player").find_child("recoil_indicator")
	pass
