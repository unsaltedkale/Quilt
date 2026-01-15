extends Node2D

@export var bar_appear: float = 0
@export var beat_appear: float = 0
@export var bar_delete: float = 0
@export var beat_delete: float = 0
@onready var Conductor = $"../../Conductor"
@export var only_on_music_trigger_track: bool
@export var music_trigger: music_resource = preload("res://Alex's Folder/music_resources/crypt_1_sub.tres")
@export var repeat_pattern: bool
@export var mod_bar = 0
@export var mod_beat = 0

func _ready():
	get_node("../CollisionShape2D").disabled = true
	get_parent().visible = false
	pass
	
func _physics_process(delta):
	if Conductor != null:
		if Conductor.barnumber != null or Conductor.beatnumber != null:
			if music_trigger.track.resource_path.get_file().get_basename() != Conductor.current_music_resource.track.resource_path.get_file().get_basename() and only_on_music_trigger_track == true:
				get_node("../CollisionShape2D").disabled = true
				get_parent().visible = false
			else:
				if repeat_pattern == true:
					var working_bar = fmod(Conductor.barnumber,mod_bar) + 1
					var working_beat = Conductor.beatnumber
					if mod_beat != 0:
						working_beat = fmod(Conductor.beatnumber,mod_beat) + 1
					if Conductor.barnumber == 1 && Conductor.beatnumber == 1:
						if bar_appear != 1 || beat_appear != 1:
							get_node("../CollisionShape2D").disabled = true
							get_parent().visible = false
					if bar_appear == working_bar and beat_appear == working_beat and get_node("../CollisionShape2D").disabled == true:
						get_node("../CollisionShape2D").disabled = false
						get_parent().visible = true
					if bar_delete == working_bar and beat_delete == working_beat and get_node("../CollisionShape2D").disabled == false:
						get_node("../CollisionShape2D").disabled = true
						get_parent().visible = false
				if repeat_pattern == false:
					if Conductor.barnumber == 1 && Conductor.beatnumber == 1:
						if bar_appear != 1 || beat_appear != 1:
							get_node("../CollisionShape2D").disabled = true
							get_parent().visible = false
					if bar_appear == Conductor.barnumber and beat_appear == Conductor.beatnumber and get_node("../CollisionShape2D").disabled == true:
						get_node("../CollisionShape2D").disabled = false
						get_parent().visible = true
					if bar_delete == Conductor.barnumber and beat_delete == Conductor.beatnumber and get_node("../CollisionShape2D").disabled == false:
						get_node("../CollisionShape2D").disabled = true
						get_parent().visible = false
