extends Node

@onready var SFXBusIndex = AudioServer.get_bus_index("SFXMaster")
@onready var GeneralBusIndex = AudioServer.get_bus_index("Master")
@onready var DialogueBusIndex = AudioServer.get_bus_index("DialougeMaster")
@onready var DialogueEchoBusIndex = AudioServer.get_bus_index("DialougeEcho")
@onready var MusicSliderBusIndex = AudioServer.get_bus_index("MusicMaster")

func _process(_delta: float) -> void:
	AudioServer.set_bus_volume_db(SFXBusIndex, SettingsData.SFXVolumeValue)
	AudioServer.set_bus_volume_db(GeneralBusIndex, SettingsData.generalVolumeValue)
	AudioServer.set_bus_volume_db(DialogueBusIndex, SettingsData.dialogueVolumeValue)
	AudioServer.set_bus_volume_db(MusicSliderBusIndex, SettingsData.MusicVolumeValue)
