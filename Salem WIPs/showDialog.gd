extends Node


var dialog = load("res://Salem/ExampleCharacterLines.tres")

func _ready() -> void:
	push_error(dialog.text["intro"]) #make this actually print on the screen
