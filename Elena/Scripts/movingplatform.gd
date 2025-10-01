extends CharacterBody2D

@export var speed := 100
@export var distance := 200

var start_position
var direction := 1

func _ready():
	start_position = position

func _physics_process(delta):
	velocity.x = speed * direction
	
	move_and_slide()
	
	if position.x > start_position.x + distance:
		direction = -1
	elif position.x < start_position.x - distance:
		direction = 1
