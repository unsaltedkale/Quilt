extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	anim.play("unactive_checkpoint")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.set_checkpoint(global_position)
		anim.play("active_checkpoint")
		print("checkpoint activated")
