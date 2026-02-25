extends Area2D
@onready var player = $"../Player"

var speed : Vector2 = Vector2(-2000,-2000)
var projectile_direction
var joystick_direction


func _process(delta):
	$Sprite2D.play("FIRE")
	rotation = projectile_direction.angle() + 135
	

func _on_projectile_entered(body:Node2D):
	if body.is_in_group("tilemap"):
		queue_free()
		
func _on_area_entered(body: Area2D):
	if body.is_in_group("Stasis"):
		queue_free()
