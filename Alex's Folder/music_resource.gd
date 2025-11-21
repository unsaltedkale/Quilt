@tool
extends Resource
class_name music_resource

@export var track: AudioStream
@export var bpm: float = 60
@export var timesig: float = 4
@export var offset: float
@export var levels_found_in: Array
