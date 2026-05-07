extends AnimatedSprite2D

@onready var conductor = get_tree().get_first_node_in_group("Conductor")
@onready var upper_s = $Sprite2D
@onready var upper_s_2 = $Sprite2D2
@onready var upper_s_3 = $Sprite2D3
@onready var upper_s_4 = $Sprite2D4
@onready var fade_speed = 0.05
@onready var off_screen = Vector2(-100, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_s.modulate.a = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	'''if conductor != null && upper_s.modulate.a != null:
		if conductor.beatnumber != null && conductor.barnumber != null && str(conductor.current_music_resource.resource_path) != "res://Alex's Folder/music_resources/empty_music.tres":
			if conductor.beatnumber >= floor(conductor.beatnumber) && conductor.beatnumber <= floor(conductor.beatnumber)+0.25:
				upper_s.modulate.a = 1
				#print(conductor.barnumber)
			#elif conductor.beatnumber == floor(conductor.beatnumber)+0.5:
				#upper_s.modulate.a = 0.5
			else:
				upper_s.modulate.a = upper_s.modulate.a - fade_speed
				
		else:
			#upper_s.modulate.a =- fade_speed * _delta
			upper_s.modulate.a = upper_s.modulate.a - fade_speed
	print(upper_s.modulate.a)'''
	
	if SettingsData.isMetronome == false:
		visible = false
	else:
		visible = true
	
	if conductor != null && upper_s.modulate.a != null:
		if conductor.beatnumber != null && conductor.barnumber != null && str(conductor.current_music_resource.resource_path) != "res://Alex's Folder/music_resources/empty_music.tres":
			upper_s.global_position = music_calc(false, conductor.barnumber, conductor.beatnumber, 1, 1)
			upper_s_2.global_position = music_calc(false, conductor.barnumber, conductor.beatnumber, 1, 3)
			upper_s_3.global_position = music_calc(true, conductor.barnumber, conductor.beatnumber, 1, 1)
			upper_s_4.global_position = music_calc(true, conductor.barnumber, conductor.beatnumber, 1, 3)
	pass
	
func music_calc(reverse: bool, bar: float, beat: float, goal_bar: float, goal_beat: float):
	
	off_screen.y = global_position.y
	
	var v = Vector2(0,0)
	
	var temp_os = off_screen
	
	if reverse == true:
		temp_os.x += 2*abs(temp_os.x - global_position.x)
	
	#var i = fmod(beat,1)
	
	var i = fmod(beat - 1 + (goal_beat - 1),4)
	
	if beat == goal_beat:
		i = 4
	
	#print(str(beat) + " , " + str(i))
	
	# FROM off_screen TO metronome position
	v = temp_os.lerp(global_position, i / 4)
	
	return v
	pass
