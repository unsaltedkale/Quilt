extends Node

var speed = 20
var mousePosition
var direction
var isPressed = false

func _process(delta: float) -> void:
	print(isPressed)
	if isPressed == true: 
		direction = mousePosition - self.position
		self.position += speed * direction.normalized()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		isPressed = true
		mousePosition = event.position
	
