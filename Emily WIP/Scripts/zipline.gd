extends Area2D
@onready var player = $"../Player"
@onready var sprite = $"Sprite2D"

@export var platform_speed: Vector2 = Vector2(.05,.05)
@export var end_position: Vector2 = Vector2(6470,1234)

func _ready() -> void:
	sprite.play("idle")

func _process(delta: float) -> void:
	if player.is_suspended_zipline:
		player.velocity = Vector2(0,0)
		position += platform_speed*delta*position
		player.position = position
	if basically_zero(self.position, end_position) and player.is_suspended_zipline:
		player.is_suspended_zipline = false
		sprite.play("break")
		print("at end")
		

func basically_zero(u: Vector2, v: Vector2) -> bool:
	var i: int
	i = 0
	if (u.x - v.x < 0.01):
		i += 1
	
	if (u.y - v.y < 0.01):
		i += 1
		
	if (i == 2):
		return true
	else:
		return false

func on_body_entered(area : Area2D):
	if player.is_suspended_zipline:
		if area.is_in_group("Projectile"):
			player.velocity = player.recoil_component.recoil_velocity_equation()
			player.is_suspended_zipline = false
			player.is_exiting_stasis = true
			sprite.play("carry")
	else:
		if area.is_in_group("Projectile") or area.is_in_group("Player"):
			player.is_suspended_zipline = true
			player.position = position
			print("zipline pos: ",position)
			player.collected_objects = player.max_stars
			sprite.play("carry")

func on_body_exited(body: CharacterBody2D):
	if body.is_in_group("Player"):
		player.is_suspended_zipline = false
