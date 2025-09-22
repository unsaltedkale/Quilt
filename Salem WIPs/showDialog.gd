extends Label


var dialog = load("res://Salem WIPs/ExampleCharacterLines.tres")

func _ready() -> void:
	text = dialog.text["intro"]
