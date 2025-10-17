extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var recoil_component: RecoilComponent

var health_script: Node

func _ready():
	health_script = $PlayerHealth  
	health_script.health = health_script.max_health  

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	recoil_component.handle_movement(self, input_component.get_shoot_input())

	move_and_slide()

#player ability function
var can_shoot: bool = true

func take_damage(amount: int) -> void:
	health_script.reduce_health(amount)
	
func _process(delta):
	if Input.is_action_just_pressed("fire_projectile") and can_shoot:
		shoot()
		
func shoot():
	var proj = preload("res://Emily WIP/Scenes/red_projectile.tscn").instantiate()
	owner.add_child(proj)
	proj.transform = $Marker2D.global_transform
	can_shoot = true
