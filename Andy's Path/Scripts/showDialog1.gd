extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = []
var dialogue_counter
var isTyping
var font_size = 30

var playerReference
var dialogueReference
var UiReference

signal dialouge_finished

func _ready() -> void:
	playerReference = $"../../../../../Player"
	dialogueReference = $"../Dialogue"
	UiReference = $"../.."
	
	dialogue_counter = 0
	dialogueReference.add_theme_font_size_override("font_size", font_size)
func _on_pressed() -> void:
	if dialogFolder != null:
		line = dialogFolder.text[str(dialogue_counter)]
	if not isTyping:
		dialogueReference.visible_characters = 0
		isTyping = true
		text = line
		for i in len(line):
			dialogueReference.visible_characters += 1
			await wait(0.02)
		if dialogue_counter > len(dialogFolder.text) - 2:
			UiReference.visible = false
			$"../../../../../NPCs/TestNPC".isPressed = false	
			dialogue_counter = 0
			dialouge_finished.emit()
		isTyping = false
		dialogue_counter += 1
func _process(delta: float) -> void:
	#if Input.is_action_pressed("interact"):
		#Dialogue("res://Alex's Folder/cutscene_event_resources/cutscenes/crypt_fall_cutscene/dia resources/crypt_fall_dialouge.tres")
	pass
func wait(duration):
	await get_tree().create_timer(duration).timeout
func Dialogue(dialogueResource):
	UiReference.visible = true
	playerReference.find_child("StateMachine").find_child("Cutscene").Transition.emit(Player, "cutscene")
	dialogFolder = load(dialogueResource)
