extends CharacterBody2D

class_name Player

@export var is_phlo: bool = false
var collected_objects: int
@export var max_objects: int
var is_stasis: bool = false

@export var max_health: int = 1
var health: int
var spawn_point
var shrine_key: bool = false

func _ready() -> void:
	health = max_health
	spawn_point = global_position

func _process(_delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
#HEALTH/DAMAGE STUFF	
func take_damage(amount: int) -> void:
	health -= amount
	$"SFX/Take Damage".play()
	if health <= 0:
		die()
	#allows for different damage amounts if we ever want to do that
		
func die():
	print_debug("Player died")
	spawn_player(spawn_point)
	
func _on_hit_box_body_entered(body: Node2D) -> void:
	print_debug("NAME:" + str(body.name))
	if body.is_in_group("Damage_Layer"):
		take_damage(1)
		
	
#Respawn
func set_checkpoint(pos):
	spawn_point = pos
	
func spawn_player(spawn_point: Vector2):
	global_position = spawn_point
	velocity = Vector2.ZERO
	health = max_health  
	
'''
@export var wall_stick_component: WallStickComponent
@export var crouch_component: CrouchComponent

var max_health: int = 1
var health: int

var was_on_floor: bool = false
var is_jumping: bool = false
var is_falling: bool = false
var is_landing: bool = false
@export var is_phlo: bool = false
var shrine_key: bool = false
var is_suspended_stasis: bool = false
var is_suspended_zipline: bool = false
var is_exiting_stasis: bool = false
@export var is_cutscene: bool = false
var is_magical_wall: bool = false


func _ready():
	health = max_health
	if is_cutscene == null:
		is_cutscene = false

func _process(delta: float) -> void:
	if is_phlo:
		handle_phlo_animation(delta)
		get_node("CollisionShape2D").disabled = true
		get_node("CollisionShape2D2").disabled = false
	else:
		handle_animation(delta)
		get_node("CollisionShape2D").disabled = false
		get_node("CollisionShape2D2").disabled = true
		
	

func _physics_process(delta: float) -> void:
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	joystick_pos = joystick_direction
	
	if not is_cutscene:
		if not is_suspended_stasis or not is_suspended_zipline:
			gravity_component.handle_gravity(self, delta)
			movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
		jump_component.handle_jump(self, input_component.get_jump_input())
		recoil_component.handle_recoil(self, input_component.get_shoot_input())
		wall_stick_component.handle_wall(self, delta)
		crouch_component.handle_crouch(self, input_component.get_crouch_input())
	
	move_and_slide()
	if is_on_floor() && not is_phlo:
		collected_objects = max_stars
	if collected_objects > 0:
		can_shoot = true
	else:
		can_shoot = false
	if Input.is_action_just_pressed("fire_projectile") or abs(joystick_direction) > Vector2(0,0):
		#print(joystick_pos)
		if can_shoot and not is_cutscene and abs(joystick_pos) == Vector2(0,0):
			print("FIREBALL")
			#just shot bool --> cooldown for controler
			shoot()

func on_body_entered(body):
	if body.is_in_group("Magical_Barrier"):
		is_magical_wall = true
		velocity.y = 0
		
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Damage_Layer"):
		print("You hit a Spike")
		take_damage(1)
		
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	
func die():
	print("Player died")
	spawn_player(spawn_point)
	
func set_checkpoint(pos):
	spawn_point = pos
	
func spawn_player(spawn_point: Vector2):
	global_position = spawn_point
	velocity = Vector2.ZERO
	health = max_health  
	
func shoot():
	var proj = projectile_scene.instantiate()
	proj.position = position
	get_parent().add_child(proj)
	joystick_direction = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
	if abs(joystick_direction) > Vector2(0,0):
		proj.projectile_direction = (position - joystick_direction)
	else:
		proj.projectile_direction = (position - get_global_mouse_position()).normalized()
	
	collected_objects -= 1

func handle_animation(delta):
	# movement animations
	var current_velocity = velocity.x
	
	if is_cutscene:
		current_velocity = (position.x - previous_position_x) / delta
		
	if previous_velocity > current_velocity and is_on_floor() and abs(previous_velocity - current_velocity) > 10:
		turn_towards_right_count += 1
		if turn_towards_right_count == 3:
			$AnimatedSprite2D.play("stop")
			$AnimatedSprite2D.flip_h = false
	elif previous_velocity < current_velocity and is_on_floor() and abs(previous_velocity - current_velocity) > 10:
		turn_towards_left_count += 1
		if turn_towards_left_count == 3:
			$AnimatedSprite2D.play("stop")
			$AnimatedSprite2D.flip_h = true
	elif current_velocity > 0:
		turn_towards_left_count = 0
		turn_towards_right_count = 0
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif current_velocity < 0:
		turn_towards_left_count = 0
		turn_towards_right_count = 0
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	elif not $AnimatedSprite2D.is_playing():
		turn_towards_left_count = 0
		turn_towards_right_count = 0
		$AnimatedSprite2D.play("idle")
	previous_velocity = current_velocity
	previous_position_x = position.x
	# jump animations
	is_jumping = velocity.y < 0 and not is_on_floor()
	is_falling = velocity.y >= 0 and not is_on_floor()
	var current_on_floor: bool = is_on_floor()
	
	if not was_on_floor and current_on_floor:
		is_landing = true
	else:
		is_landing = false
	
	if is_jumping and $AnimatedSprite2D.animation != "jump":
		$AnimatedSprite2D.play("jump")
	elif is_falling and $AnimatedSprite2D.animation != "fall":
		$AnimatedSprite2D.play("fall")
	elif is_landing and $AnimatedSprite2D.animation != "land":
		$AnimatedSprite2D.play("land")
	else:
		pass
		
	was_on_floor = current_on_floor
	
func handle_phlo_animation(delta):
	var current_velocity = velocity.x
	
	if is_cutscene:
		current_velocity = (position.x - previous_position_x) / delta
	
	if previous_velocity > current_velocity and is_on_floor():
		turn_towards_left_count = 0
		turn_towards_right_count += 1
		if turn_towards_right_count == 3:
			$AnimatedSprite2D.play("phlo_idle")
			$AnimatedSprite2D.flip_h = false
	elif previous_velocity < current_velocity and is_on_floor():
		turn_towards_right_count = 0
		turn_towards_left_count += 1
		if turn_towards_left_count == 3:
			$AnimatedSprite2D.play("phlo_idle")
			$AnimatedSprite2D.flip_h = true
	elif current_velocity > 0:
			$AnimatedSprite2D.play("phlo_idle")
			$AnimatedSprite2D.flip_h = false
	elif current_velocity < 0:
			$AnimatedSprite2D.play("phlo_idle")
			$AnimatedSprite2D.flip_h = true
	elif not $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("phlo_idle")
	previous_velocity = current_velocity
	previous_position_x = position.x
	# jump animations
	is_jumping = velocity.y < 0 and not is_on_floor()
	is_falling = velocity.y >= 0 and not is_on_floor()
	var current_on_floor: bool = is_on_floor()
	
	if not was_on_floor and current_on_floor:
		is_landing = true
	else:
		is_landing = false
	
	if is_jumping and $AnimatedSprite2D.animation != "phlo_jump":
		$AnimatedSprite2D.play("phlo_jump")
	elif is_falling and $AnimatedSprite2D.animation != "phlo_fall":
		$AnimatedSprite2D.play("phlo_fall")
	elif is_landing and $AnimatedSprite2D.animation != "phlo_land":
		$AnimatedSprite2D.play("phlo_land")
	else:
		pass
		
	was_on_floor = current_on_floor

'''
