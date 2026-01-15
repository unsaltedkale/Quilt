extends Node2D

var UiReference
var areaReferecnce
var cameraReference
var targetZoom

var isPressed = false

func _ready() -> void:
	UiReference = $"../../CanvasLayer/UI"
	areaReferecnce = $Area2D
	cameraReference = $"../../Camera2D"
	
	UiReference.visible = false

func _process(delta: float) -> void:
	if areaReferecnce.isInTrigger == true:
		if Input.is_action_just_pressed("interact"):
			if isPressed == true:
				isPressed = false
			else:
				isPressed = true
				
	if isPressed == true:
		UiReference.visible = true
	else:
		UiReference.visible = false
	
#func Display_Text_No_Input():
	#if areaReferecnce.isInTrigger == true:
	#	print("In Trigger")
	#	labelReference.visible = true
	#	
	#else:
	#	print("Out of Trigger")
	#	labelReference.visible = false
	
