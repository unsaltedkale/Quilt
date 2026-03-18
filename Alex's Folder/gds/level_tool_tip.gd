extends AnimatedSprite2D

@export var type: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play(type)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.play(type)
	pass
