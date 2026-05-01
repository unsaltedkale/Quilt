extends Node

var textSize
var generalVolumeValue
var dialogueVolumeValue
var SFXVolumeValue
var MusicVolumeValue
var isColorblind

func _ready() -> void:
	await get_tree().process_frame
	
	$TextSize.value = SettingsData.textSize
	$VolumeSettings/GeneralVolume.value = SettingsData.generalVolumeValue
	$VolumeSettings/DialogueSlider.value = SettingsData.dialogueVolumeValue
	$VolumeSettings/SoundFXSlider.value = SettingsData.SFXVolumeValue
	$VolumeSettings/MusicSlider.value = SettingsData.MusicVolumeValue
	
	self.visible = false
#	if $"../../../../Title Screen" != null:
#		$MainMenuReturn.visible = false
#		$MainMenuReturn.disabled = true

func _process(delta: float) -> void:
	textSize = $TextSize.value
	generalVolumeValue = $VolumeSettings/GeneralVolume.value
	dialogueVolumeValue = $VolumeSettings/DialogueSlider.value
	SFXVolumeValue = $VolumeSettings/SoundFXSlider.value
	MusicVolumeValue = $VolumeSettings/MusicSlider.value
	SettingsData.updateValues(textSize, generalVolumeValue, dialogueVolumeValue, SFXVolumeValue, MusicVolumeValue)
	
func _force_open():
	get_tree().paused = true
	self.visible = true

func _input(event: InputEvent) -> void:
	if self.visible == true:
		if event.is_action_pressed("settings"):
			get_tree().paused = false
			self.visible = false
	else:
		if event.is_action_pressed("settings"):
			get_tree().paused = true
			self.visible = true
