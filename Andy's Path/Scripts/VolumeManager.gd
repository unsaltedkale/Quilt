extends Node

@onready var SoundFXSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/SoundFXSlider"
@onready var GeneralSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/GeneralVolume"
@onready var DialogueSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/DialogueSlider"
@onready var DialogueEchoSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/DialogueEchoSlider"
@onready var MusicSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/MusicSlider"
@onready var SFXBusIndex = AudioServer.get_bus_index("SFXMaster")
@onready var GeneralBusIndex = AudioServer.get_bus_index("Master")
@onready var DialogueBusIndex = AudioServer.get_bus_index("DialougeMaster")
@onready var DialogueEchoBusIndex = AudioServer.get_bus_index("DialougeEcho")
@onready var MusicSliderBusIndex = AudioServer.get_bus_index("MusicMaster")

func _process(_delta: float) -> void:
	AudioServer.set_bus_volume_db(SFXBusIndex, SoundFXSlider.value)
	AudioServer.set_bus_volume_db(GeneralBusIndex, GeneralSlider.value)
	AudioServer.set_bus_volume_db(DialogueBusIndex, DialogueSlider.value)
	AudioServer.set_bus_volume_db(DialogueEchoBusIndex, DialogueEchoSlider.value)
	AudioServer.set_bus_volume_db(MusicSliderBusIndex, MusicSlider.value)
