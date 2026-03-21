extends Area2D
class_name zipline_obj

@onready var player = $"../Player"
@onready var ani = $Sprite2D
@export var timer: float = 0

@export var speed: float = 500
@onready var start_position: Vector2
@export var end_position: Vector2 = Vector2(6470,1234)
@export var respawning: bool
@export var respawn_time = 3

func _ready() -> void:
	respawning = false
	start_position = position
	ani.play("idle")

func _physics_process(_delta: float) -> void:
	if timer > 0:
		timer -= _delta
	else:
		timer = 0
	if player != null:
		if basically_zero(position, end_position) && not respawning:
			player.current_stasis = null
			var tempvar = player.find_child("StateMachine").current_state
			tempvar.Transition.emit(tempvar, "fall")
			ani.play("break")
			respawning = true
			await wait(respawn_time)
			visible = false
			position = start_position
			visible = true
			respawning = false
		elif player.current_stasis == self:
			ani.play("carry")
			position = position.move_toward(end_position, speed * _delta)
			timer = 0.5 #seconds
			player.position = position
		elif not respawning:
			ani.play("idle")

func on_body_entered(area: Area2D):
	if timer <= 0 && not respawning:
		if area.is_in_group("Projectile") or area.get_parent().is_in_group("Player"):
			player.current_stasis = self
			player.position = position
			player.collected_objects = player.max_objects
			if not $"SFX/Stasis Hum".is_playing():
				$"SFX/Stasis Hum".play()
			if not $"SFX/Enter Stasis".is_playing():
				$"SFX/Enter Stasis".play()
			ani.play("catch")

func on_body_exited(area: Area2D):
	print("click")
	if area.get_parent().is_in_group("Player"):
		print("player left")
		#player.current_stasis = null
		$"SFX/Stasis Hum".stop()
		$"SFX/Exit Stasis".play()

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

func wait(duration):
	await get_tree().create_timer(duration).timeout

'''extends Area2D
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
		player.is_suspended_zipline = false'''
