extends ColorRect

func _ready():
	$".".modulate = Color.RED

func _input(event: InputEvent) -> void:
	if event.is_action("Action1"):
		$".".modulate = Color.WHITE
	else:
		$".".modulate = Color.RED
