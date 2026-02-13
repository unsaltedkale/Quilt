extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var can_get_twice: bool
var active

func _ready():
	anim.play("unactive_checkpoint")
	active = false

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player") and active==false:
		body.set_checkpoint(global_position)
		active = true
		anim.play("active_checkpoint")
		print("checkpoint activated")
		
	if body.is_in_group("Player") and active==true:
		
		if can_get_twice == true:
			body.set_checkpoint(global_position)
			anim.play("active_checkpoint")
			print("checkpoint activated")
		
		if can_get_twice == false: 
			print("cannot activate this checkpoint again")
