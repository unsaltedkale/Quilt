extends Node

func _ready() -> void:
	self.visible = false
	
	if $"../../../../Title Screen" != null:
		$MainMenuReturn.visible = false
		$MainMenuReturn.disabled = true

func _force_open():
	get_tree().paused = true
	self.visible = true

func _input(event: InputEvent) -> void:
	if self.visible == true:
		if event.is_action_pressed("settings"):
			get_tree().paused = false
			self.visible = false
	else:
		if event.is_action_pressed("settings"):
			get_tree().paused = true
			self.visible = true
