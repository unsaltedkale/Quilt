extends Node2D

var labelReference
var areaReferecnce

func _ready() -> void:
	labelReference = $Label
	areaReferecnce = $Area2D

func _process(delta: float) -> void:
	Display_Text_With_Input()
	
func Display_Text_No_Input():
	if areaReferecnce.isInTrigger == true:
		print("In Trigger")
		labelReference.visible = true
		
	else:
		print("Out of Trigger")
		labelReference.visible = false
		
func Display_Text_With_Input():
	if areaReferecnce.isInTrigger == true && Input.is_action_pressed("interact"):
		print("In Trigger")
		labelReference.visible = true
		
	else:
		print("Out of Trigger")
		labelReference.visible = false
