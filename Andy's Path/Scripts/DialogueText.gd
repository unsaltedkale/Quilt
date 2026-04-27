extends Label

@onready var buttonReference = $"../Button"

func _process(_delta: float) -> void:
	text = buttonReference.text
