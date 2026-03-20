extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = ""
var dialogue_counter
var isTyping
var font_size = 30

var playerReference
var dialogueReference
var UiReference

signal dialouge_finished

func _ready() -> void:
	playerReference = get_tree().get_nodes_in_group("Player")[0]
	dialogueReference = $"../Dialogue"
	UiReference = $"../.."
	
	UiReference.visible = false
	dialogue_counter = 0
	dialogueReference.add_theme_font_size_override("font_size", font_size)

func _input(event: InputEvent) -> void:
	pass
	#probably works but commenting it out just in case -- alex
	#if event.is_action_pressed("interact") && dialogFolder != null:
		#_on_pressed()

func _on_pressed() -> void:
	if dialogFolder != null:
		line = dialogFolder.text[str(dialogue_counter)]
	if not isTyping:
		print("boop")
		dialogueReference.visible_characters = 0
		isTyping = true
		text = line
		for i in len(line):
			await wait(0.01) # moving this before fixed number not moving up
			dialogueReference.visible_characters += 1
			#print(str(i) + " / " + str(dialogueReference.visible_characters) + " / " + str(len(line)))
			
		if dialogue_counter > len(dialogFolder.text) - 2:
			UiReference.visible = false
			#$"../../../../NPCs/TestNPC".isPressed = false	
			dialogue_counter = 0
			dialouge_finished.emit()
		isTyping = false
		dialogue_counter += 1 #<-- having this at the end is causing problems -- alex
func _process(delta: float) -> void:
	print(str(dialogue_counter) + " / " + str(UiReference.visible))
	if Input.is_action_pressed("interact"):
		Dialogue("res://Alex's Folder/cutscene_event_resources/cutscenes/Crypt/crypt_fall_cutscene/dia resources/crypt_fall_dialouge.tres")
	pass
func wait(duration):
	await get_tree().create_timer(duration).timeout
func Dialogue(dialogueResource):
	await wait(0.01) # <-- makes it so the dialogue_counter += 1
	# doesn't overide the = 0 at the end of this function
	UiReference.visible = true
	playerReference.find_child("StateMachine").find_child("Cutscene").Transition.emit(Player, "cutscene")
	dialogFolder = load(dialogueResource)
	dialogue_counter = 0
