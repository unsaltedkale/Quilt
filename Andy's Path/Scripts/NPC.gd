extends Node2D

var labelReference
var areaReferecnce
var cameraReference

var isPressed = false

func _ready() -> void:
	labelReference = $Label
	areaReferecnce = $Area2D
	cameraReference = $"../../Camera2D"

func _process(delta: float) -> void:
	Display_Text_With_Input()
	print(isPressed)
	
func Display_Text_No_Input():
	if areaReferecnce.isInTrigger == true:
		print("In Trigger")
		labelReference.visible = true
		
	else:
		print("Out of Trigger")
		labelReference.visible = false
		
func Display_Text_With_Input():
	if areaReferecnce.isInTrigger == true:
		if Input.is_action_just_pressed("interact"):
			if isPressed == true:
				isPressed = false
			else:
				isPressed = true
				
	if isPressed == true:
		labelReference.visible = true
		cameraReference.Zoom(0.5,0.5)
	else:
		labelReference.visible = false
