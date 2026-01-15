extends Node2D

var npcReference
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	npcReference = $"../NPCs/TestNPC"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if npcReference.UiReference.visible == true:
		get_tree().paused = true
	else:
		get_tree().paused = false
