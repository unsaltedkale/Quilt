extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = []
var dialogue_counter = 0
var isTyping = false

func _ready() -> void:
	dialogue_counter = 0
func _on_pressed() -> void:
	if dialogFolder != null:
		line = dialogFolder.text[str(dialogue_counter)]
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
		print("print statement: " + str(len(dialogFolder.text)))
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		Dialogue("res://Andy's Path/Resources/TestLines.tres")
func wait(duration):
	await get_tree().create_timer(duration).timeout
func Dialogue(dialogueResource):
	$"../..".visible = true
	$"../../../../Player".is_cutscene = true
	dialogFolder = load(dialogueResource)
