extends StaticBody2D

@onready var timer: Timer = $VanishingTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		timer.start()

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
	collision_shape_2d.position = Vector2(-10000, 20000)
