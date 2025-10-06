extends Node2D
	
var velocity = 0
var maxVelocity = 100
var acceleration = 0.1

var positiveAcceleration = true

func _process(delta: float) -> void:
	$".".position.x += acceleration * velocity
	if velocity >= maxVelocity:
		velocity = maxVelocity
		positiveAcceleration = false
	else: if velocity <= -maxVelocity:
		positiveAcceleration = true
		
		
	if positiveAcceleration == true:
		velocity += 1
	else:
		velocity -= 1
