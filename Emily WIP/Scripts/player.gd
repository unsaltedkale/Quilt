extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@onready var projectile_scene = preload("res://Emily WIP/Scenes/red_projectile.tscn")

var health_script: Node
var speed = 150
var player_direction

func _ready():
	health_script = $PlayerHealth  
	health_script.health = health_script.max_health  

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())

	move_and_slide()
	
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		shoot()
		recoil()

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

func recoil():
	player_direction = (position - get_global_mouse_position()).normalized()
	position += player_direction * speed 
