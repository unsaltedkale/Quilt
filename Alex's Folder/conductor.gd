extends Node2D

@onready var audioplayer = $"../AudioStreamPlayer"
@export var current_music_resource: music_resource
@onready var bpm: float = current_music_resource.bpm
@onready var quarternote: float
@onready var eighthnote: float
@onready var sixteenthnote: float
@onready var offset
@onready var beatnumber = 1
@onready var barnumber = 1
@onready var timesig = 4
@onready var songposition
@onready var lastbeat = 0

func _ready():
	quarternote = 60/bpm
	eighthnote = 30/bpm
	sixteenthnote = 15/bpm
	audioplayer.stream = current_music_resource.track
	bpm = current_music_resource.bpm
	timesig = current_music_resource.timesig
	offset = current_music_resource.offset
	audioplayer.play()
	print(barnumber, ", ", beatnumber)
	pass
	
func _process(delta: float) -> void:
	songposition = audioplayer.get_playback_position() + offset
	if (songposition > lastbeat + sixteenthnote):
		lastbeat += sixteenthnote
		beatnumber += 0.25
		if (beatnumber > timesig+(1-sixteenthnote)):
				barnumber += 1
				beatnumber = 1
		print(barnumber, ", ", beatnumber)

enum music_transition_enum {immediate, next_beat, next_bar, end}

func _change_music_track(m_resource: music_resource):
	audioplayer.stop()
	audioplayer.stream = m_resource.track
	bpm = m_resource.bpm
	timesig = m_resource.timesig
	offset = m_resource.offset
	beatnumber = 1
	barnumber = 1
	lastbeat = 0
	quarternote = 60/bpm
	eighthnote = 30/bpm
	sixteenthnote = 15/bpm
	print(barnumber, ", ", beatnumber)
	audioplayer.play()
	print(bpm)
	print("changed")
