extends CharacterBody2D

@onready var player = $"../Player"
@onready var ani = find_child("AnimatedSprite2D")
@onready var timer_max = 0.3
@onready var timer = 0
@onready var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
			if player.find_child("AnimatedSprite2D").flip_h == true && ani.flip_h == false:
				ani.flip_h = true
				position = player.position + Vector2(33,-40)
			if player.find_child("AnimatedSprite2D").flip_h == false && ani.flip_h == true:
				ani.flip_h = false
				position = player.position + Vector2(-33,-40)
			if player.position != position:
				var target
				if player.find_child("AnimatedSprite2D").flip_h == true:
					target = player.position + Vector2(33,-40)
				else:
					target = player.position + Vector2(-33,-40)
				velocity = velocity.move_toward(target, speed)
