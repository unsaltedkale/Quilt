extends Node2D

@export var base: float
@export var speed: float = 6
@export var mult: float = -1
@export var sp: AnimatedSprite2D

enum c {crypt, orange, yellow_bright, yellow_dark}

@export var color: c = c.crypt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base = sp.scale.x
	sp.play(c.keys()[color])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if sp.scale.x < -base:
		mult = 1
		pass
	
	elif sp.scale.x > base:
		mult = -1
		pass
	
	sp.scale.x += delta * speed * mult
	
	pass
