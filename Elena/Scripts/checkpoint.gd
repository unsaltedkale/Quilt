extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var can_get_twice: bool
@export var original_position: Vector2
@export var inactive_position: Vector2
var active

func _ready():
	original_position = position
	inactive_position = original_position + Vector2(0, 25)
	position = inactive_position
	anim.play("unactive_checkpoint")
	active = false

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player") and active==false:
		body.set_checkpoint(global_position)
		active = true
		anim.play("active_checkpoint")
		position = original_position
		print("checkpoint activated")
		
	if body.is_in_group("Player") and active==true:
		
		if can_get_twice == true:
			body.set_checkpoint(global_position)
			anim.play("active_checkpoint")
			position = original_position
			print("checkpoint activated")
		
		if can_get_twice == false: 
			print("cannot activate this checkpoint again")
