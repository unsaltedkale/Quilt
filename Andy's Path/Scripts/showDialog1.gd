extends Button


@export var dialogFolder = load("res://Andy's Path/Resources/ExampleCharacterLines.tres")

func _ready() -> void:
	text = dialogFolder.text["0"]
