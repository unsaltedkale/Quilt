extends AudioStreamPlayer

var sd1 = get_parent()
@export var voices : Dictionary[String, AudioStream]

const dialouge_type = preload("res://Andy's Path/Scripts/showDialog1.gd").dialouge_type

var pitch
var newnote = 1

func _voice_time(character_speaking: String, letter_displayed: String, line_type: dialouge_type):
	#print("cs: " + character_speaking)
	#print("ld: " + letter_displayed)
	#print("lt: " + dialouge_type.keys()[line_type]) #speech, thought, or narration
	match letter_displayed:
		"i", "I":
			newnote -= 1
			pitch_scale = 1
		"a", "A":
			newnote -= 1
			pitch_scale = 0.9
		"e", "E":
			newnote -= 1
			pitch_scale = 0.8
		"o", "O":
			newnote -= 1
			pitch_scale = 0.6
		"u", "U":
			newnote -= 1
			pitch_scale = 0.4
		_:
			pass
	if newnote <= 0 and line_type == dialouge_type.speech:
		for character in voices.keys():
			if character == character_speaking:
				stream = voices[character]
		stop()
		play()
		newnote = 2 #how many vowels per note
