extends Node2D

@export var bar_appear: float = 1
@export var beat_appear: float = 1
@export var bar_delete: float = 1
@export var beat_delete: float = 0
@onready var Conductor = get_tree().get_first_node_in_group("Conductor")
@export var only_on_music_trigger_track: bool
@export var music_trigger: music_resource = preload("res://Alex's Folder/music_resources/LIVE music/LIVE_substratum.tres")
@export var repeat_pattern: bool = true
@export var mod_bar = 1
@export var mod_beat = 0
@export var active = true

func _ready():
	if active == true:
		set_(false)
	pass
	
func _physics_process(_delta): #Why is this in physics process?
	if Conductor != null && active == true:
		if Conductor.barnumber != null or Conductor.beatnumber != null:
			if only_on_music_trigger_track == true:
				if music_trigger.track.resource_path.get_file().get_basename() != Conductor.current_music_resource.track.resource_path.get_file().get_basename():
					set_(false)
			else:
				if repeat_pattern == true:
					
					# FOR FUTURE SELF (alex wrote this):
					
					# 1. I <3 uuuuuu!!!
					
					# 2. modulo is weird
					
					# 3. To repeat on bar, set Mod Bar to the bar number BEFORE it resets
					
					# example: to repeat every 4 bars, set to four, because it will reset on bar 5
					
					# it will read 1, 2, 3, 4, 1, 2, 3, 4, etc.
					
					# ur welcome ok i <3 u good luck!!!!
					
					
					var working_bar = fmod(Conductor.barnumber,mod_bar)
					if working_bar == 0:
						working_bar = mod_bar
					var working_beat = Conductor.beatnumber
					if mod_beat != 0:
						working_beat = fmod(Conductor.beatnumber,mod_beat)
						if working_beat == 0:
							working_beat = mod_beat
					#print_debug(working_bar,working_beat)
					if Conductor.barnumber == 1 && Conductor.beatnumber == 1:
						if bar_appear != 1 || beat_appear != 1:
							set_(false)
					if Conductor.barnumber == 1 && Conductor.beatnumber == 1:
							if bar_appear == 1 && beat_appear == 1:
								set_(true)
					if bar_appear == working_bar and beat_appear == working_beat and get_node("../CollisionShape2D").disabled == true:
						set_(true)
					if bar_delete == working_bar and beat_delete == working_beat and get_node("../CollisionShape2D").disabled == false:
						set_(false)
				
				
				if repeat_pattern == false:
					if Conductor.barnumber == 1 && Conductor.beatnumber == 1:
						if bar_appear != 1 || beat_appear != 1:
							set_(false)
					if bar_appear == Conductor.barnumber and beat_appear == Conductor.beatnumber and get_node("../CollisionShape2D").disabled == true:
						set_(true)
					if bar_delete == Conductor.barnumber and beat_delete == Conductor.beatnumber and get_node("../CollisionShape2D").disabled == false:
						set_(false)
	else:
		#print("condcutor is null")
		pass
		
func set_(b: bool):
	# TRUE == platform exists, FALSE == platform does not exist
	get_node("../CollisionShape2D").disabled = !b
	if !b:
		get_parent().modulate = Color(0, 0, 0, 0.3)
	else:
		get_parent().modulate = Color(1,1,1)
	pass
