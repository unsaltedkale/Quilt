extends Area2D

@onready var player = $"../Player"

func _process(_delta):
	if player.is_suspended_stasis:
		player.velocity = Vector2(0,0)
		print("payer vel: ",player.velocity)
		player.position = position # take out and gets right stasis, gravity active
		print("stasis pos: ", position)

func on_body_entered(area: Area2D):
	if not player.is_suspended_stasis:
		if area.is_in_group("Projectile") or area.is_in_group("Player"):
			player.is_suspended_stasis = true
			print("stasis pos: ", position)
			player.position = position #in list of stasis, get collided stasis
			player.collected_objects = player.max_stars
	else:
		if area.is_in_group("Projectile"):
			player.velocity = player.recoil_component.recoil_velocity_equation()
			player.is_suspended_stasis = false
			player.is_exiting_stasis = true

func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		player.is_suspended_stasis = false
		player.is_exiting_stasis = false
