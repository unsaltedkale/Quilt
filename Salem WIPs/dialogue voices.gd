extends AudioStreamPlayer

var sd1 = get_parent()
@export var voices : Dictionary[String, AudioStream]

const dialouge_type = preload("res://Andy's Path/Scripts/showDialog1.gd").dialouge_type

var pitch
var newnote = 1
var newnotemax
var original_volume
var pitch_hold

func _ready() -> void:
	newnote = 0
	original_volume = volume_db
	
func _start_of_new_line():
	newnote = 0
	pass

func _voice_time(character_speaking: String, letter_displayed: String, line_type: dialouge_type):
	#print("cs: " + character_speaking)
	#print("ld: " + letter_displayed)
	#print("lt: " + dialouge_type.keys()[line_type]) #speech, thought, or narration
	
	var phlo_pitches = [1, 0.9, 0.8, 0.6, 0.4]
	var quilt_pitches = [1.0 / 3, 0.9 / 3, 0.8 / 3, 0.6 / 3, 0.4 / 3]
	var flow_pitches = [1, 0.9, 0.8, 0.6, 0.4]
	var pyra_pitches = [1.0 / 2, 0.9 / 2, 0.8 / 2, 0.6 / 2, 0.4 / 2]
	
	var p = []
	
	match character_speaking:
		"phlo":
			if p != phlo_pitches:
				p = phlo_pitches
				pitch_hold = p[randi_range(0, 4)]
			newnotemax = 1
		"quilt":
			if p != quilt_pitches:
				p = quilt_pitches
				pitch_hold = p[randi_range(0, 4)]
			newnotemax = 3
		"flow":
			if p != flow_pitches:
				p = flow_pitches
				pitch_hold = p[randi_range(0, 4)]
			newnotemax = 2
		"pyra":
			if p != pyra_pitches:
				p = pyra_pitches
				pitch_hold = p[randi_range(0, 4)]
			newnotemax = 4
	if line_type != dialouge_type.narration:
		match letter_displayed:
			"i", "I":
				newnote -= 1
				pitch_hold = p[0]
				
			"a", "A":
				newnote -= 1
				pitch_hold = p[1]
			"e", "E":
				newnote -= 1
				pitch_hold = p[2]
			"o", "O":
				newnote -= 1
				pitch_hold = p[3]
			"u", "U":
				newnote -= 1
				pitch_hold = p[4]
			_:
				pass
	if newnote <= 0 and line_type != dialouge_type.narration:
		if line_type == dialouge_type.speech:
			bus = &"Master"
			pass
		if line_type == dialouge_type.thought:
			bus = &"Dialouge Echo"
			pass
		pitch_scale = pitch_hold
		for character in voices.keys():
			if character == character_speaking:
				stream = voices[character]
				stop()
				play()
		newnote = newnotemax #how many vowels before a new vowel plays
