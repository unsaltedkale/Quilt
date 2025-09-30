extends Node

var speed = 20
var mousePosition
var pressedPosition;
var direction
var isPressed = false

func _process(delta: float) -> void:
	print(isPressed)
	if isPressed == true:
		direction = pressedPosition - self.position
		self.position += speed * direction.normalized()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			mousePosition = event.position
			pressedPosition = mousePosition
		else:
			isPressed = false
