extends RichTextLabel

@onready var sm = $"../StateMachine"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var smcs = sm.current_state
	var player = $".."
	
	var crouch = Input.is_action_pressed("crouch")
	var fc = player.force_crouch
	
	text = smcs.name + "
	Crouch Held: " + str(crouch) + "
	Crouch Forced: " + str(player.force_crouch)
	pass
