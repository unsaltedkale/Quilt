extends Node

func _ready() -> void:
	self.visible = false
	
func _input(event: InputEvent) -> void:
	if self.visible == true:
		if event.is_action_pressed("settings"):
			get_tree().paused = false
