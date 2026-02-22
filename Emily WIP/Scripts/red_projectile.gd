extends Area2D
@onready var player = $"."
#@onready var mirror = $Mirror
@export var speed : Vector2
var projectile_direction
var joystick_direction


func _process(delta):
	$Sprite2D.play("FIRE")
	rotation = projectile_direction.angle()
	position += projectile_direction * speed * delta
	

func _on_projectile_entered(body:Node2D):
	if body.is_in_group("tilemap"):
		queue_free()
	
func _on_area_entered(body: Area2D):
	if body.is_in_group("Stasis"):
		queue_free()
			
		

		
		
	
