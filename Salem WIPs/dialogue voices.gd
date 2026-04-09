extends Node

var sd1 = get_parent()
@export var voices : Dictionary[String, AudioStream]

const dialouge_type = preload("res://Andy's Path/Scripts/showDialog1.gd").dialouge_type

func _ready() -> void:
	pass

func _voice_time(character_speaking: String, letter_displayed: String, line_type: dialouge_type):
	print("cs: " + character_speaking)
	print("ld: " + letter_displayed)
	print("lt: " + dialouge_type.keys()[line_type])
	
	#does not make sound on capital letters. sometimes dialouge has captial letters. idk.
	
	match letter_displayed: #TODO:  SET PIITCH
		"a":
			print("it  a")
		"e":
			pass
		"i":
			pass
		"o":
			pass
		"u":
			pass
		_:
			return
	for character in voices.keys():
		if character == character_speaking:
			var note = AudioStreamPlayer.new()
			note.stream = voices[character]
			note.autoplay = true
			note.finished.connect(note.queue_free)
			add_child(note)
