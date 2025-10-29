extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var recoil_component: RecoilComponent
@onready var projectile_scene = preload("res://Emily WIP/Scenes/red_projectile.tscn")

var health_script: Node
var was_on_floor: bool = false
var is_jumping: bool = false
var is_falling: bool = false
var is_landing: bool = false
var previous_velocity = 0


func _ready():
	health_script = $PlayerHealth  
	health_script.health = health_script.max_health  

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	recoil_component.handle_recoil(self, input_component.get_shoot_input())
	
	move_and_slide()
	handle_animation()
	
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		shoot()

#player ability function
var can_shoot: bool = true

func take_damage(amount: int) -> void:
	health_script.reduce_health(amount)

func shoot():
	var proj = projectile_scene.instantiate()
	proj.position = position
	get_parent().add_child(proj)
	proj.projectile_direction = (position - get_global_mouse_position()).normalized()
	can_shoot = true

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
	is_jumping = velocity.y > 0 and not is_on_floor()
	is_falling = velocity.y < 0 and not is_on_floor()
	var current_on_floor: bool = is_on_floor()
	
	if not was_on_floor and current_on_floor:
		is_landing = true
	else:
		is_landing = false
		
	if is_jumping:
		$AnimatedSprite2D.play("jump")
	elif is_falling:
		$AnimatedSprite2D.play("fall")
	elif is_landing:
		$AnimatedSprite2D.play("land")
		
	was_on_floor = current_on_floor
	
