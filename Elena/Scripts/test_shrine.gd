extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.shrine_key == true: 
		print("You unlocked the Shrine!")
		body.shrine_key = false
		anim.play("open_shrine")
		
