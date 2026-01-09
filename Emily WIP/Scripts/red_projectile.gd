extends Area2D
@onready var player = $"../Player"
var speed : Vector2 = Vector2(-500,-500)
var projectile_direction

func _process(delta):
	$Sprite2D.play("FIRE")
	position += projectile_direction * speed * delta
	rotation = projectile_direction.angle() + 135

func _on_projectile_entered(body:Node2D):
	if body.is_in_group("tilemap"):
		queue_free()
		
func _on_area_entered(body: Area2D):
	if player.is_suspended:
		pass
	else:
		if body.is_in_group("Stasis"):
			queue_free()
