extends Node2D

var labelReference
var areaReferecnce

var isPressed = false

func _ready() -> void:
	labelReference = $Label
	areaReferecnce = $Area2D

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
	if isPressed == true:
		labelReference.visible = true
	else:
		labelReference.visible = false
	if areaReferecnce.isInTrigger == true:
		#print("In Trigger")
		if Input.is_action_just_pressed("interact"):
			if isPressed == true:
				isPressed = false
			else:
				isPressed = true
	else:
		pass
		#print("Out of Trigger")
