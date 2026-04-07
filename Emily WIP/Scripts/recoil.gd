extends State

@export var force : Vector2 = Vector2(1500,1500)
@export var timer: float
@onready var projectile_scene = preload("res://Emily WIP/Scenes/red_projectile.tscn")
var player_direction
var joystick_direction
var n : Vector2
var value

signal shoot_projectile()

func recoil_vel_equation():
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	player_direction = player.get_local_mouse_position().normalized()
	if joystick_direction.x != 0 || joystick_direction.y != 0:
		n = joystick_direction.normalized()
	else:
		if player.r_calc == player.recoil_calculation_type.from_player:
			n = player_direction
		elif player.r_calc == player.recoil_calculation_type.from_center_of_screen:
			n = (get_viewport().get_mouse_position() - Vector2(player.get_viewport_rect().size.x/2, player.get_viewport_rect().size.y/2)).normalized()
			pass
	value = n * force * -1
	return value

func shoot():
	var proj = projectile_scene.instantiate()
	proj.global_position = player.global_position
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	if joystick_direction.length() > 0:
		proj.projectile_direction = joystick_direction.normalized()
	else:
		if player.r_calc == player.recoil_calculation_type.from_player:
			proj.projectile_direction = (player.get_global_mouse_position() - player.global_position).normalized()
		elif player.r_calc == player.recoil_calculation_type.from_center_of_screen:
			var center = get_viewport().get_visible_rect().size / 2
			proj.projectile_direction = (get_viewport().get_mouse_position() - center).normalized()
	get_tree().current_scene.add_child(proj)
	shoot_projectile.emit()

func Enter():
	shoot()
	player.velocity = recoil_vel_equation()
	player.collected_objects -= 1
	recoil = true
	
func Physics_Update(_delta):
	timer -= 1
	if timer <=0:
		Transition.emit(self,"fall")
	if player.is_on_floor():
		Transition.emit(self, "idle")
	if player.current_stasis != null:
		Transition.emit(self, "stasis")

func _physics_process(_delta) -> void:
	pass

func Exit():
	recoil = false
