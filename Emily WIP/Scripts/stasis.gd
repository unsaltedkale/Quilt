extends Area2D
class_name stasis_obj

@onready var player = $"../Player"
@export var timer: float = 0
@onready var ani = $Sprite2D


func _physics_process(_delta: float) -> void:
	if timer > 0:
		timer -= _delta
	else:
		timer = 0
	if player != null:
		if player.current_stasis == self:
			timer = 0.5 #seconds
			player.position = position
		elif player.current_stasis != self && ani.animation == "capture":
			ani.play("release")
			pass

func on_body_entered(area: Area2D):
	if timer <= 0:
		if area.is_in_group("Projectile") or area.get_parent().is_in_group("Player"):
			print(area)
			player.current_stasis = self
			player.position = position
			player.collected_objects = player.max_objects
			if not $"SFX/Stasis Hum".is_playing():
				$"SFX/Stasis Hum".play()
			if not $"SFX/Enter Stasis".is_playing():
				$"SFX/Enter Stasis".play()
			ani.play("capture")
			

func on_body_exited(area: Area2D):
	print("click")
	if area.get_parent().is_in_group("Player"):
		print("player left")
		#player.current_stasis = null
		$"SFX/Stasis Hum".stop()
		$"SFX/Exit Stasis".play()
