extends Node

var textSize = 0
var generalVolumeValue = 0
var dialogueVolumeValue = 0
var SFXVolumeValue = 0
var MusicVolumeValue = 0
var isColorblind = 0

func updateValues(new_text_size, new_general, new_dialogue, new_sfx, new_music):
	textSize = new_text_size
	generalVolumeValue = new_general
	dialogueVolumeValue = new_dialogue
	SFXVolumeValue = new_sfx
	MusicVolumeValue = new_music
