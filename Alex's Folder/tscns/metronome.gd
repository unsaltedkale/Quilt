extends AnimatedSprite2D

@onready var conductor = get_tree().get_first_node_in_group("Conductor")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if conductor != null:
		if conductor.beatnumber != null && conductor.barnumber != null:
			if conductor.beatnumber == floor(conductor.beatnumber):
				if str(conductor.current_music_resource.resource_path) != "res://Alex's Folder/music_resources/empty_music.tres":
					play("on")
					print(conductor.barnumber)
				else:
					play("off")
			else:
				play("off")
	else:
		play("off")
	pass
