extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var projectile_component: ProjectileComponent

var health_script: Node

func _ready():
	health_script = $PlayerHealth  # Assumes you have a PlayerHealth node as a child
	health_script.health = health_script.max_health  # Corrected variable name

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())

	move_and_slide()

#player ability function

func take_damage(amount: int) -> void:
	health_script.reduce_health(amount)
