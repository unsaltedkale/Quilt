extends Sprite2D

@onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var v = (player.get_global_mouse_position() - player.position).normalized()
	rotation = v.angle() + deg_to_rad(90)
	pass
