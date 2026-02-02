extends Label

@onready var buttonReference = $"../Button"

func _process(delta: float) -> void:
	text = buttonReference.text
