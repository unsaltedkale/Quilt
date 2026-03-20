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
	if joystick_direction > Vector2(0,0) or joystick_direction < Vector2(0,0):
		n = joystick_direction
	else:
		n = player_direction
	value = n * force * -1
	return value

func shoot():
	var proj = projectile_scene.instantiate()
	player.add_child(proj)
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	if abs(joystick_direction) > Vector2(0,0):
		proj.projectile_direction = (proj.position - joystick_direction)
	else:
		proj.projectile_direction = (proj.get_global_mouse_position() - player.position).normalized()
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
