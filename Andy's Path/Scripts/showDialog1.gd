extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = []
var dialogue_counter = 0
var isTyping = false

signal dialouge_finished

func _ready() -> void:
	dialogue_counter = 0
func _on_pressed() -> void:
	$"../Dialogue".visible_characters = 1
	if dialogFolder != null:
		line = dialogFolder.text[str(dialogue_counter)]
	if not isTyping:
		isTyping = true
		text = line
		for i in len(line):
			$"../Dialogue".visible_characters += 1
			await wait(0.02)
		dialogue_counter += 1
		if dialogue_counter < len(dialogFolder.text):
			line = dialogFolder.text[str(dialogue_counter)]
		else:
			$"../..".visible = false
			$"../../../../NPCs/TestNPC".isPressed = false	
			dialogue_counter = 0
			dialouge_finished.emit()
		isTyping = false
		print("visible chars: " + str($"../Dialogue".visible_characters))
func _process(delta: float) -> void:
	pass
	if Input.is_action_just_pressed("interact"):
		Dialogue("res://Alex's Folder/cutscene_event_resources/cutscenes/crypt_fall_cutscene/dia resources/crypt_fall_dialouge.tres")
func wait(duration):
	await get_tree().create_timer(duration).timeout
func Dialogue(dialogueResource):
	$"../..".visible = true
	$"../../../../Player".find_child("StateMachine").find_child("Cutscene").Transition.emit(Player, "cutscene")
	dialogFolder = load(dialogueResource)
