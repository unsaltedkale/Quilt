extends Node

@onready var SoundFXSlider = $"../CanvasLayer/DialogueUi/UI/Settings/VolumeSettings/SoundFXSlider"
@onready var busIndex = AudioServer.get_bus_index("SFX Master")

func _process(delta: float) -> void:
	#print(SoundFXSlider.value)
	AudioServer.set_bus_volume_db(busIndex, SoundFXSlider.value)
