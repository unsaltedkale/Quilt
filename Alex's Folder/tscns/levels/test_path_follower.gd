extends Path2D

@export var inc = 0
@export var speed = 800
@onready var Conductor = $"../Conductor"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Conductor.current_music_resource == load("res://Alex's Folder/music_resources/crypt_2_ebb_OUTRO.tres"):
		inc+=delta*speed
		$PathFollow2D.progress = inc
	else:
		inc = 0
	pass
