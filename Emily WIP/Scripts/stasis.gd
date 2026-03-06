extends Area2D

@onready var player = $"../Player"
@export var timer: float = 0

func _physics_process(_delta: float) -> void:
	if timer > 0:
		timer -= 1 * _delta
	else:
		timer = 0
	if player.is_stasis:
		player.position = position

func on_body_entered(area: Area2D):
	if timer <= 0:
		if area.is_in_group("Projectile") or area.is_in_group("Player"):
			player.is_stasis = true
			player.position = position
			player.collected_objects = player.max_objects
