extends Button


@export var dialogFolder = load("res://Andy's Path/Resources/ExampleCharacterLines.tres")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	for i in dialogFolder.text:
		text = text + dialogFolder.text[str(i)]
