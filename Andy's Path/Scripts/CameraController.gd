extends Camera2D

var initialPosition
var offset1 = 500

var playerReference
var screenIsMoving

var target

func _ready() -> void:
	initialPosition = self.global_position
	screenIsMoving = false
	
	playerReference = $"../Player"
	
func _process(delta: float) -> void:
	print(screenIsMoving)
	
	self.global_position.x = lerp(self.global_position.x, playerReference.global_position.x, delta * 2)
	if screenIsMoving == false:
		if playerReference.global_position.y <= initialPosition.y - offset1:
			target = playerReference.global_position.y
			screenIsMoving = true
		elif playerReference.global_position.y >= initialPosition.y + offset1:
			target = playerReference.global_position.y
			screenIsMoving = true
	else:
		initialPosition = self.global_position
		self.global_position.y = lerp(self.global_position.y, target, delta)
		if (self.global_position.y - target) < 5:
			self.position.y = target
			screenIsMoving = false
