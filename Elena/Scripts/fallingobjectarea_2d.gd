extends Area2D

@export var damage_amount: int = 1

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	
	if body.is_in_group("Player"):
		body.take_damage(damage_amount)
		
	elif body.is_in_group("Environmental Feature"):
		print("Falling Object hit an Environmental Feature")
		start_destruction_timer()
		
	elif body is TileMapLayer: 
		print("Falling Object hit the Ground")
		start_destruction_timer()

func start_destruction_timer() -> void:
	await get_tree().create_timer(.5).timeout
	print("Destroying Falling Object")
	get_parent().queue_free()
	
