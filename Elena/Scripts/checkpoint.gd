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
		
		#this is alex. i changed it so that when you are phlo the
		#checkpoints are red and when you are quilt the checkpoints are
		#white. that is all :D
		
		position = original_position
		if body.is_phlo == true:
			anim.play("active_checkpoint_red")
		else:
			anim.play("active_checkpoint_white")
			position += Vector2(0,5)
		
		print("checkpoint activated")
		
	if body.is_in_group("Player") and active==true:
		
		if can_get_twice == true:
			body.set_checkpoint(global_position)
			position = original_position
			if body.is_phlo == true:
				anim.play("active_checkpoint_red")
			else:
				anim.play("active_checkpoint_white")
				position += Vector2(0,5)
			
			print("checkpoint activated")
		
		if can_get_twice == false: 
			print("cannot activate this checkpoint again")
