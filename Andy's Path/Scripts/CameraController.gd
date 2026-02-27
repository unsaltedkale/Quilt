extends Camera2D

var offset1 = 400 #screen bounds

var playerReference
var screenIsMoving
var has_control: bool

func _ready() -> void:
	has_control = true
	screenIsMoving = false
	
	playerReference = $"../Player"
	
func _process(delta: float) -> void:
	if has_control:	
		#Horizontal Movement
		self.global_position.x = lerp(self.global_position.x, playerReference.global_position.x, delta * 2)

		if screenIsMoving == false:
			if abs(self.global_position.y - playerReference.global_position.y) > offset1:
				screenIsMoving = true
		else:
			#Vertical Movement
			self.global_position.y = lerp(self.global_position.y, playerReference.global_position.y, delta * 10)
			
			#Move to target position if magnitude of distance < 10
			if abs((self.global_position.y - playerReference.global_position.y)) < 5:
				screenIsMoving = false
