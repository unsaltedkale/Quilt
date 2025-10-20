extends Area2D

@export var damage_amount: int = 1

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	
	if body.has_method("take_damage"):
		body.take_damage(damage_amount)
		
	if body is TileMapLayer: 
		print("Falling Object hit the ground")
		get_parent().queue_free()
	
