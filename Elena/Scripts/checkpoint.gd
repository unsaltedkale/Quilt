extends Area2D

var active := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _process(_delta) -> void:
	if active == false:
		anim.play("unactive_checkpoint")
	

func _on_body_entered(body):
	if active == true:
		return
		
	if body.is_in_group("Player"):
		active = true
		anim.play("active_checkpoint")
		GameManager.save_checkpoint(global_position)
	
	
	
	
	
	
	
	
	
	
