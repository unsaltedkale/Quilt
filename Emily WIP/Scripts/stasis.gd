extends Area2D

@onready var player = $"../Player"


func on_body_entered(area: Area2D):
	if player.is_suspended:
		if area.is_in_group("Projectile"):
			player.is_suspended = false
	else:
		if area.is_in_group("Projectile"):
			print("collided")
			player.is_suspended = true
			player.velocity = Vector2(0,0)
			player.position = position 
			player.collected_objects = player.max_stars
func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		player.is_suspended = false
