extends Area2D
@onready var player = $"../Player"

var platform_speed: Vector2 = Vector2(.05,0)
@export var end_position: Vector2 = Vector2(6470,1234)

func _process(delta: float) -> void:
	if player.is_suspended_zipline:
		player.velocity = Vector2(0,0)
		player.position = position
		position += platform_speed*delta*position
	if player.position >= end_position and player.is_suspended_zipline:
		player.is_suspended_zipline = false
		queue_free()
		print("at end")
		

func on_body_entered(area : Area2D):
	if player.is_suspended_zipline:
		if area.is_in_group("Projectile"):
			player.velocity = player.recoil_component.recoil_velocity_equation()
			player.is_suspended_zipline = false
			player.is_exiting_stasis = true
	else:
		if area.is_in_group("Projectile") or area.is_in_group("Player"):
			player.is_suspended_zipline = true
			player.position = position
			print("zipline pos: ",position)
			player.collected_objects = player.max_stars

func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		player.is_suspended_zipline = false
