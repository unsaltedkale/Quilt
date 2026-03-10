extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = []
var dialogue_counter
var isTyping = false

signal dialouge_finished

func _ready() -> void:
	dialogue_counter = 0
func _on_pressed() -> void:
	$"../Dialogue".visible_characters = 0
	if dialogFolder != null:
		line = dialogFolder.text[str(dialogue_counter)]
	if not isTyping:
		isTyping = true
		text = line
		for i in len(line):
			$"../Dialogue".visible_characters += 1
			await wait(0.02)
		if dialogue_counter > len(dialogFolder.text) - 2:
			$"../..".visible = false
			$"../../../../NPCs/TestNPC".isPressed = false	
			dialogue_counter = 0
			dialouge_finished.emit()
		isTyping = false
		dialogue_counter += 1
func _process(delta: float) -> void:
	#print("print: " + str(dialogue_counter))
	if Input.is_action_pressed("interact"):
		Dialogue("res://Alex's Folder/cutscene_event_resources/cutscenes/crypt_fall_cutscene/dia resources/crypt_fall_dialouge.tres")
func wait(duration):
	await get_tree().create_timer(duration).timeout
func Dialogue(dialogueResource):
	$"../..".visible = true
	$"../../../../Player".find_child("StateMachine").find_child("Cutscene").Transition.emit(Player, "cutscene")
	dialogFolder = load(dialogueResource)
