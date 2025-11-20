extends Node

class_name Projectile

var speed = 20
var mousePosition
var pressedPosition
var direction = Vector2.ZERO
var isPressed = false
var acceleration = Vector2(0, 9.8)
var velocity = Vector2.ZERO

func _process(_delta: float) -> void:
	if isPressed == true:
		direction = pressedPosition - self.position
	if direction != Vector2.ZERO:
		velocity += speed * direction.normalized() * _delta
		velocity += acceleration * _delta
		self.position += velocity
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			mousePosition = event.position
			pressedPosition = mousePosition
		else:
			isPressed = false
