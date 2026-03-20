extends Area2D
class_name stasis_obj

@onready var player = $"../Player"
@export var timer: float = 0

func _physics_process(_delta: float) -> void:
	if timer > 0:
		timer -= _delta
	else:
		timer = 0
	if player.current_stasis == self:
		timer = 0.5 #seconds
		player.position = position

func on_body_entered(area: Area2D):
	if timer <= 0:
		if area.is_in_group("Projectile") or area.get_parent().is_in_group("Player"):
			player.current_stasis = self
			player.position = position
			player.collected_objects = player.max_objects
			$"SFX/Stasis Hum".play()
			$"SFX/Enter Stasis".play()

func on_body_exited(area: Area2D):
	if area.get_parent().is_in_group("Player"):
		print("player left")
		#player.current_stasis = null
		$"SFX/Stasis Hum".stop()
		$"SFX/Exit Stasis".play()
