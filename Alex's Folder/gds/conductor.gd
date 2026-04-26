extends Node2D

@onready var audioplayer = $"../AudioStreamPlayer"
@export var current_music_resource: music_resource
@onready var bpm: float = current_music_resource.bpm
@onready var quarternote: float
@onready var eighthnote: float
@onready var sixteenthnote: float
@onready var thirtysecondnote: float
@onready var offset
@export var beatnumber = 1
@export var barnumber = 1
@onready var timesig = 4
@onready var songposition
@onready var lastbeat = 0

@onready var prev_playback_position

@onready var hudc= $"../CanvasLayer/Heads-up Conductor"
@onready var heads_up_display_moving

func _ready():
	quarternote = 60/bpm
	eighthnote = 30/bpm
	sixteenthnote = 15/bpm
	thirtysecondnote = 15.0/2.0/bpm
	audioplayer.stream = current_music_resource.track
	bpm = current_music_resource.bpm
	timesig = current_music_resource.timesig
	offset = current_music_resource.offset
	audioplayer.play()
	print(barnumber, ", ", beatnumber)
	prev_playback_position = audioplayer.get_playback_position()
	
	heads_up_display_moving = false
	
	if current_music_resource != preload("res://Alex's Folder/music_resources/empty_music.tres"):
		_heads_up_conductor(current_music_resource)
	
	pass
	
func _process(delta: float) -> void:
	songposition = audioplayer.get_playback_position() + offset
	if prev_playback_position > audioplayer.get_playback_position():
		reset_conductor_numbers()
	prev_playback_position = audioplayer.get_playback_position()
	if (songposition > lastbeat + thirtysecondnote):
		lastbeat += thirtysecondnote
		beatnumber += 0.125
		if (beatnumber > timesig+(1-thirtysecondnote)):
				barnumber += 1
				beatnumber = 1
		#print(barnumber, ", ", beatnumber)

enum music_transition_enum {immediate, next_beat, next_bar, end}

func _change_music_track(m_resource: music_resource, change_if_same_music_track: bool):
	if change_if_same_music_track == false && m_resource.track == audioplayer.stream:
		pass
	else:
		audioplayer.stop()
		if current_music_resource != m_resource && m_resource != preload("res://Alex's Folder/music_resources/empty_music.tres"):
			_heads_up_conductor(m_resource)
		current_music_resource = m_resource
		audioplayer.stream = m_resource.track
		bpm = m_resource.bpm
		timesig = m_resource.timesig
		offset = m_resource.offset
		reset_conductor_numbers()
		audioplayer.play()

func _heads_up_conductor(mr: music_resource):
	hudc._execute(mr)
	
func reset_conductor_numbers():
	beatnumber = 1
	barnumber = 1
	lastbeat = 0
	quarternote = 60/bpm
	eighthnote = 30/bpm
	sixteenthnote = 15/bpm
	thirtysecondnote = 15.0/2.0/bpm
	#print(barnumber, ", ", beatnumber)
	#print(bpm)
	print_debug("changed")
