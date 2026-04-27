extends Button


var dialogFolder
var text_list = []
var char_list = []
var line = ""
var dialogue_counter
var isTyping
var font_size
var settings_flag = false

var playerReference
var dialogueReference
var UiReference
var sliderReference
var characterportraitReference
var settingsReference

enum dialouge_type {speech, thought, narration}

signal dialouge_finished

func _ready() -> void:
	dialogueReference = $"../Dialogue"
	UiReference = $".."
	sliderReference = $"../../Settings/HSlider"
	characterportraitReference = $"../CharacterPortrait"
	settingsReference = $"../../Settings"
	
	font_size = sliderReference.value
	
	UiReference.visible = false
	dialogue_counter = -1
	dialogueReference.add_theme_font_size_override("font_size", font_size)

func _input(event: InputEvent) -> void:
	if dialogue_counter != -1:
		if event.is_action_pressed("interact") || event.is_action_pressed("jump") || event.is_action_pressed("fire_projectile"):
			if dialogFolder != null:
				_tick()
			#get_tree().paused = !get_tree().paused <-- make this work later
			#pause/unpause the music
			#somehow pause camera tweening if it is running

func _parse(l: String, b: bool = false):

	var ws = l
	
	var start = l.find("%")
	
	var end = l.find("%", start + 1)
	
	var pic = l.substr(start, end + 1)
	
	var picClean = pic.replace("%", "")
	
	#if animation not found throw error and play empty. b is for whether
	# to change the portrait or not.
	if b == true && characterportraitReference.sprite_frames.get_animation_names().has(picClean):
		characterportraitReference.play(picClean)
	elif b == true:
		print_debug("ERROR: Animation for Character Portrait (name: <%s> )not found.", picClean)
	
	ws = ws.replace(pic, "")
	
	if ws[0] == " ":
		ws = ws.substr(1)
		#print("space cleaned")
	
	#print("l: |" + l)
	#print("ws: |" + ws)
	#print("pic: |" + pic)
	
	return ws

func _handle_voice() -> void:
	
	var letter_displayed
	var character_speaking
	var line_type
	
	var l = dialogFolder.text[str(dialogue_counter)]
	
	var start = l.find("%")
	
	var end = l.find("_", start + 1)
	
	var pic = l.substr(start, end + 1)
	
	var picClean = pic.replace("%", "")
	
	picClean = picClean.replace("_", "")
	
	character_speaking = picClean
	
	#print("cs: " + character_speaking)
	
	if dialogueReference.visible_characters < _parse(dialogFolder.text[str(dialogue_counter)]).length():
		letter_displayed = _parse((dialogFolder.text[str(dialogue_counter)])[dialogueReference.visible_characters])
	else:
		letter_displayed = ""
	#print("ld: " + letter_displayed)
	
	if dialogFolder.text[str(dialogue_counter)].findn("[") != -1:
		line_type = dialouge_type.narration
	elif dialogFolder.text[str(dialogue_counter)].findn("(") != -1:
		line_type = dialouge_type.thought
	else:
		line_type = dialouge_type.speech
	
	# Does not hand off character speaking indicator to the voice box
	if line_type != dialouge_type.narration:
		var seperator = _parse(dialogFolder.text[str(dialogue_counter)]).find(":")
		if dialogueReference.visible_characters <= seperator + 1:
			letter_displayed = ""
	
	$"Voice Player"._voice_time(character_speaking, letter_displayed, line_type)
	
	#print("l: |" + l)
	#print("ws: |" + ws)
	#print("pic: |" + pic)
	
	pass

func _tick() -> void:
	
	font_size = sliderReference.value
	dialogueReference.add_theme_font_size_override("font_size", font_size)
	
	if not dialogue_counter == -1:
		if dialogFolder != null:
			line = dialogFolder.text[str(dialogue_counter)]
		if line.contains("%"):
			characterportraitReference.play("empty")
			line = _parse(line, true)
		if not isTyping:
			#print("boop")
			dialogueReference.visible_characters = 0
			isTyping = true
			text = line
			$"Voice Player"._start_of_new_line()
			for i in len(line):
				await wait(0.03) # moving this before fixed number not moving up
				dialogueReference.visible_characters += 1
				_handle_voice()
			
				if len(line) < dialogueReference.visible_characters:
					break # ^ checks if was skipped to the end
			if dialogue_counter > len(dialogFolder.text) - 2:
				UiReference.visible = false
				#$"../../../../NPCs/TestNPC".isPressed = false	
				dialogue_counter = -1
				dialouge_finished.emit()
			isTyping = false
			if dialogue_counter != -1: 
				dialogue_counter += 1 #<-- having this at the end is causing problems -- alex
		elif isTyping: # if player presses twice, line skips to the end.
			dialogueReference.visible_characters = len(line)

func _process(_delta: float) -> void:
	#if dialogueReference.visible_characters == 0 && dialogue_counter == 0:
		
	#print(str(dialogueReference.visible_characters) + " / " + str(dialogue_counter))
	#print(str(dialogue_counter) + " / " + str(UiReference.visible))
	#print(get_tree().paused)
	
	pass
		
	
	
func wait(duration):
	await get_tree().create_timer(duration).timeout
	
	
func Dialogue(dialogueResource):
	playerReference = get_tree().get_nodes_in_group("Player")[0]
	print(playerReference)
	await wait(0.01) # <-- makes it so the dialogue_counter += 1
	# doesn't overide the = 0 at the end of this function
	UiReference.visible = true
	playerReference.find_child("StateMachine").find_child("Cutscene").Transition.emit(Player, "cutscene")
	dialogFolder = load(dialogueResource)
	dialogue_counter = 0
	#print_debug("AUTO CLICKED")
	_tick()
