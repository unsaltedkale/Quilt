extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
		
		
	
func _timer() -> void:
	await get_tree().create_timer(.5).timeout
	print("Destroying Falling Object")
	get_parent().queue_free()
