extends Node

var SFXsliderValue

var SFXSlider

func _ready() -> void:
	SFXSlider = $"UI/Settings/Volume Settings/Sound FX Slider"
	
func _process(delta: float) -> void:
	pass
	
	#broken right now
	##SFXsliderValue = SFXSlider.Value
	#
	#$Player/SFX/Land.VolumedB = SFXSlider.value
	#$"Player/SFX/Take Damage".VolumedB = SFXSlider.value
	#$Player/SFX/Footsteps.VolumedB = SFXSlider.value
	#$"Player/SFX/Shoot Projectile".VolumedB = SFXSlider.value
	#$"Player/SFX/Take Damage (Phlo)".VolumedB = SFXSlider.value
	#$Player/SFX/Jump.VolumedB = SFXSlider.value"
