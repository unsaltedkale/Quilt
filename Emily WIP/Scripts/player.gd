extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var recoil_component: RecoilComponent
@export var wall_stick_component: WallStickComponent
@onready var projectile_scene = preload("res://Emily WIP/Scenes/red_projectile.tscn")

var health_script: Node
var was_on_floor: bool = false
var is_jumping: bool = false
var is_falling: bool = false
var is_landing: bool = false
@export var is_phlo: bool = false
var previous_velocity = 0
var string: String = ""
var collected_objects: int = 0 
var max_stars: int = 2
var can_shoot: bool = true
var shrine_key: bool = false
var is_suspended: bool = false


func _ready():
	health_script = $PlayerHealth  
	health_script.health = health_script.max_health  

func _physics_process(delta: float) -> void:
	if is_phlo:
		handle_phlo_animation()
		get_node("CollisionShape2D").disabled = true
		get_node("CollisionShape2D2").disabled = false
	else:
		handle_animation()
		get_node("CollisionShape2D").disabled = false
		get_node("CollisionShape2D2").disabled = true
		
	if not is_suspended:
		gravity_component.handle_gravity(self, delta)
		movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	if not is_phlo:
		recoil_component.handle_recoil(self, input_component.get_shoot_input())
	wall_stick_component.handle_wall(self, delta)
	
	move_and_slide()
	if is_on_floor():
		collected_objects = max_stars
	if collected_objects > 0:
		can_shoot = true
	else:
		can_shoot = false
	if Input.is_action_just_pressed("fire_projectile") and can_shoot and not is_phlo:
		shoot()

func take_damage(amount: int) -> void:
	health_script.reduce_health(amount)

func shoot():
	var proj = projectile_scene.instantiate()
	proj.position = position
	get_parent().add_child(proj)
	proj.projectile_direction = (position - get_global_mouse_position()).normalized()
	
	collected_objects -= 1

func handle_animation():
	# movement animations
	var current_velocity = velocity.x
	if previous_velocity > current_velocity and is_on_floor():
		$AnimatedSprite2D.play("stop")
		$AnimatedSprite2D.flip_h = false
	elif previous_velocity < current_velocity and is_on_floor():
		$AnimatedSprite2D.play("stop")
		$AnimatedSprite2D.flip_h = true
	elif current_velocity > 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif current_velocity < 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	elif not $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("idle")
	previous_velocity = current_velocity
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
	
func handle_phlo_animation():
	var current_velocity = velocity.x
	if previous_velocity > current_velocity and is_on_floor():
		$AnimatedSprite2D.play("phlo_idle")
		$AnimatedSprite2D.flip_h = false
	elif previous_velocity < current_velocity and is_on_floor():
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
