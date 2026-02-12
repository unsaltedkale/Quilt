extends Button


@export var dialogFolder = load("res://Andy's Path/Resources/ExampleCharacterLines.tres")
var text_list = []
var char_list = []
var line = []
var dialogue_counter = 0
var isTyping = false

func _ready() -> void:
	line = dialogFolder.text[str(dialogue_counter)]
	dialogue_counter = 0
func _on_pressed() -> void:
	if not isTyping:
		text = ''
		isTyping = true
		for character in range(len(line)):
			text = text + line[character]
			await wait(0.015)
		dialogue_counter += 1
		if dialogue_counter < len(dialogFolder.text):
			line = dialogFolder.text[str(dialogue_counter)]
		else:
			$"../..".visible = false
			$"../../../../Player".is_cutscene = false
			$"../../../../NPCs/TestNPC".isPressed = false	
			dialogue_counter = 0
		isTyping = false
func _process(delta: float) -> void:
	#print(dialogue_counter)
	pass
func wait(duration):
	await get_tree().create_timer(duration).timeout
