extends Node2D

var triggerReference

func _ready() -> void:
	triggerReference = $Area2D

func _process(delta: float) -> void:
	if triggerReference.isInTrigger == true:
		print("In Trigger")
	else:
		print("Out of Trigger")
