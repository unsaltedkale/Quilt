extends Camera2D

var initialPosition
var offset1 = 2

var playerReference
var screen_size
var cameraTop
var cameraBottom

var initialTopLimit
var initialBottomLimit

func _ready() -> void:
	initialPosition = self.global_position
	screen_size = get_viewport().get_visible_rect().size
	cameraTop = global_position.y + screen_size.y / 2
	cameraBottom = global_position.y - screen_size.y / 2
	
	playerReference = $"../Player"
	
	initialTopLimit = self.limit_top
	initialBottomLimit = self.limit_bottom
	
func _process(delta: float) -> void:
	print(playerReference.position.x)
	
	self.position.x = playerReference.position.x
	self.limit_top = cameraTop
	
	if playerReference.position.y >= initialTopLimit:
		cameraTop = offset1 * initialTopLimit
		initialTopLimit = self.limit_top
		
	
	
	
	
	
	
	#if self.global_position.y >= offset1 * initialTopLimit:
		#self.limit_top = initialTopLimit * offset1
		#self.limit_bottom = initialBottomLimit * -offset1
		#print("Limits expanded")
	#elif self.global_position.y <= initialBottomLimit:
		#self.limit_top = -offset1 * initialTopLimit
		#self.limit_bottom = offset1 * initialBottomLimit 
