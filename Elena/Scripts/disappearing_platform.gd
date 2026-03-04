extends RigidBody2D

@onready var timer_length: float = 1.0

func _ready() -> void:
	self.gravity_scale = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Timer.start()

func _on_timer_timeout() -> void:
	self.gravity_scale = 1
	#animation or sprite change so it appears as crumbling/pieces when its falling
