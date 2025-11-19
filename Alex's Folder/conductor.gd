extends Node2D

@onready var audioplayer = $"../AudioStreamPlayer"
@onready var bpm: float = 80
@onready var quarternote: float
@onready var eighthnote: float
@onready var sixteenthnote: float
@onready var offset = 0
@onready var beatnumber = 1
@onready var barnumber = 1
@onready var timesig = 4
@onready var songposition
@onready var lastbeat = 0

func _ready():
	quarternote = 60/bpm
	eighthnote = 30/bpm
	sixteenthnote = 15/bpm
	audioplayer.play()
	pass
	
func _physics_process(delta: float) -> void:
	songposition = audioplayer.get_playback_position() + offset
	if (songposition > lastbeat + sixteenthnote):
		lastbeat += sixteenthnote
		beatnumber += 0.25
		if (beatnumber > timesig+(1-sixteenthnote)):
				barnumber += 1
				beatnumber = 1
		print(barnumber, ", ", beatnumber)
	pass
