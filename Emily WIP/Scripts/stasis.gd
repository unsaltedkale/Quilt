extends Area2D

@onready var player = $"../Player"

func _process(delta):
	if player.is_suspended_stasis:
		player.velocity = Vector2(0,0)
		player.position = position

func on_body_entered(area: Area2D):
	if player.is_suspended_stasis and player.player_just_shoot:
		player.is_suspended_stasis = false
		player.player_just_shoot = false
	if not player.is_suspended_stasis:
		if area.is_in_group("Projectile"):
			player.is_suspended_stasis = true
			player.position = position
			player.collected_objects = player.max_stars

func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		player.is_suspended_stasis = false
