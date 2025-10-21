extends Camera2D

var initialPosition

func _ready() -> void:
	initialPosition = self.position
	
func _process(delta: float) -> void:
	print(self.position.y)
	if self.position.y >= initialPosition.y + 10:
		self.limit_top = self.limit_top + 10
		self.limit_bottom = self.limit_bottom + 10
