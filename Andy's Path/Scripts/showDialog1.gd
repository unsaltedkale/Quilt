extends Button


@export var dialogFolder = load("res://Andy's Path/Resources/ExampleCharacterLines.tres")
var text_list = []
var char_list = []
var dialogue_counter = 0
var isTyping = false
var line = []

func _process(delta: float) -> void:
	print(str(dialogue_counter) + str(len(dialogFolder.text)))
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pressed.connect(_on_pressed)
	line = dialogFolder.text[str(dialogue_counter)]
func _on_pressed() -> void:
	if not isTyping:
		text = ''
		isTyping = true
		for character in range(len(line)):
			text = text + line[character]
			await wait(0.1)
		dialogue_counter += 1
		if dialogue_counter < len(dialogFolder.text):
			line = dialogFolder.text[str(dialogue_counter)]
		else:
			$"../..".visible = false
			get_tree().paused = false
			dialogue_counter = 0
		isTyping = false

func wait(duration):
	await get_tree().create_timer(duration).timeout
