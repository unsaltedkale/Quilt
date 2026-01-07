extends Area2D
@onready var player = $"../Player"

var platform_speed: Vector2 = Vector2(.05,0)
var player_collided: bool = false
var end_position: Vector2 = Vector2(6470,1234)

func _process(delta: float) -> void:
	if player_collided:
		#player velocity = 0
		player.position = position
		position += platform_speed*delta*position
	if player.position >= end_position and player.is_suspended:
		player.is_suspended = false
		queue_free()
		print("at end")
		

func on_body_entered(area : Area2D):
	if area.is_in_group("Projectile"):
		player.is_suspended = true
		player.position = position
		player.collected_objects = player.max_stars
		player_collided = true

func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		print("player exited")
		player_collided = false
		player.is_suspended = false
