extends Area2D
class_name zipline_obj

@onready var player
@onready var ani = $Sprite2D
@export var timer: float = 0

@export var speed: float = 500
@export var start_position: Vector2
@export var end_position: Vector2 = Vector2(6470,1234)
@export var respawning: bool
@export var respawn_time = 3
@export var reverse_time: float
@export var reverse_time_max = 2

@export var dot = preload("res://Alex's Folder/tscns/zipline_dot.tscn")
@export var line = preload("res://Alex's Folder/tscns/zipline_line.tscn")

@export var particles: CPUParticles2D

func _ready() -> void:
	respawning = false
	global_position = start_position
	ani.play("idle")
	reverse_time = reverse_time_max
	if get_tree().root.get_child(0).find_child("Req") != null:
		player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
	else:
		player = $"../Player"
		
	var d = dot.instantiate()
	d.global_position = start_position
	
	var e = dot.instantiate()
	e.global_position = end_position
	
	var del = line.instantiate()
	del.clear_points()
	del.add_point(start_position)
	del.add_point(end_position)
	
	get_tree().current_scene.add_child.call_deferred(d)
	get_tree().current_scene.add_child.call_deferred(e)
	get_tree().current_scene.add_child.call_deferred(del)
	
	print(d.position)
	print(d.global_position)

func _on_player_death():
	global_position = start_position
	pass

func _physics_process(_delta: float) -> void:
	
	if timer > 0:
		timer -= _delta
	else:
		timer = 0
	if player != null:
		
		if not player.player_death.is_connected(_on_player_death):
			player.player_death.connect(_on_player_death)
		
		# if zipline is at the end of the path
		if basically_zero(global_position, end_position) && not respawning:
			
			reverse_time = reverse_time_max
			
			player.current_stasis = null
			var tempvar = player.find_child("StateMachine").current_state
			tempvar.Transition.emit(tempvar, "fall")
			ani.play("break")
			respawning = true
			await wait(respawn_time)
			visible = false
			global_position = start_position
			visible = true
			respawning = false
		
		if player.current_stasis == self:
			
			reverse_time = reverse_time_max
			
			ani.play("carry")
			global_position = global_position.move_toward(end_position, speed * _delta)
			timer = 0.5 #seconds
			player.global_position = global_position
			
			particles.emitting = true
		
		if player.current_stasis != self:
			particles.emitting = false
		
		#if zipline is in the middle of the path
		if not basically_zero(global_position, start_position) && not basically_zero(global_position, end_position):
			if player.current_stasis != self:
				ani.play("idle")
				reverse_time -= _delta
				if reverse_time <= 0:
					global_position = global_position.move_toward(start_position, 5 * speed * _delta)
					if basically_zero(global_position, start_position):
						reverse_time = reverse_time_max
			pass
		
		elif not respawning:
			reverse_time = reverse_time_max
			
			ani.play("idle")

func on_body_entered(area: Area2D):
	if timer <= 0 && not respawning:
		if area.is_in_group("Projectile") or area.get_parent().is_in_group("Player"):
			player.current_stasis = self
			player.global_position = global_position
			player.collected_objects = player.max_objects
			if not $"SFX/Stasis Hum".is_playing():
				$"SFX/Stasis Hum".play()
			if not $"SFX/Enter Stasis".is_playing():
				$"SFX/Enter Stasis".play()
			ani.play("catch")

func on_body_exited(area: Area2D):
	if area.get_parent().is_in_group("Player") && not respawning:
		#player.current_stasis = null
		$"SFX/Stasis Hum".stop()
		if not $"SFX/Exit Stasis".is_playing():
			$"SFX/Exit Stasis".play()

func basically_zero(u: Vector2, v: Vector2) -> bool:
	var i: int
	i = 0
	if (abs(u.x - v.x) < 0.01):
		i += 1
	
	if (abs(u.y - v.y) < 0.01):
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


func _on_body_exited(area: Area2D) -> void:
	pass # Replace with function body.
