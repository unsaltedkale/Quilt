extends RigidBody2D

@onready var timer_length: float = 1.0
@onready var Player: CharacterBody2D = $"../Player"

func _ready() -> void:
	self.gravity_scale = 0
	#$Timer.start()

func _on_timer_timeout() -> void:
	self.gravity_scale = 1
	#animation or sprite change so it appears as crumbling/pieces when its falling? assuming we want something better than just the block plummenting to the ground

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Player.take_damage(1)
		self.queue_free()
	
	if body.is_in_group("tilemap"):
		self.queue_free()
