extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_parent().visible = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if $"../../Button".dialogueReference.visible_ratio >= 1.0 && $"../../Button".dialogueReference.text.length() > 0:
		get_parent().visible = true
	else:
		get_parent().visible = false
	
	pass
