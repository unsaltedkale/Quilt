extends CharacterBody2D

@onready var player = $"../Player"
@onready var ani = find_child("AnimatedSprite2D")
@onready var timer_max = 0.15
@onready var timer = 0
@onready var speed = $"../Player".find_child("StateMachine").find_child("Idle").speed + 700

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = timer_max
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
			if player.find_child("AnimatedSprite2D").flip_h == true && ani.flip_h == false:
				ani.flip_h = true
				position = player.position + Vector2(33,-40)
				timer = timer_max
			if player.find_child("AnimatedSprite2D").flip_h == false && ani.flip_h == true:
				ani.flip_h = false
				position = player.position + Vector2(-33,-40)
				timer = timer_max
				
			var target
			if player.find_child("AnimatedSprite2D").flip_h == true:
				target = player.position + Vector2(35,-40)
			else:
					target = player.position + Vector2(-35,-40)
			
			position = target
			
			'''if player.position != target:
				
				timer -= delta
				
				if target.y < position.y:
					position.y = target.y
				
				var b
				if abs(target.y - position.y) > 20 || abs(target.x - position.x) > 35:
					b = true
				if b == true:
					position = position.move_toward(target, delta*speed)
					if abs(position.x - target.x) < 0.1 && abs(position.y - target.y) < 0.1:
						#position = target
						b = false'''
					
