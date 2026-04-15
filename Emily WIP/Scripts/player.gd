extends CharacterBody2D

class_name Player

@export var is_phlo: bool = false
var collected_objects: int
@export var max_objects: int
var current_stasis = null #Replaces is_stasis: we need to know which stasis chamber we're in to teleport to the right one

@export var max_health: int = 1
var health: int
var spawn_point
var shrine_key: bool = false

enum recoil_calculation_type {from_player, from_center_of_screen}

signal player_death

@export var r_calc: recoil_calculation_type

var jump_count : int

func _ready() -> void:
	health = max_health
	spawn_point = global_position

func _process(_delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if is_on_floor():
		jump_count = 0
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
#HEALTH/DAMAGE STUFF	
func take_damage(amount: int) -> void:
	health -= amount
	if is_phlo:
		$"SFX/Take Damage (Phlo)".play()
	else:
		$"SFX/Take Damage".play()
	if health <= 0:
		die()
	#allows for different damage amounts if we ever want to do that
		
func die():
	print_debug("Player died")
	$"../Camera2D".player_died()
	player_death.emit()
	spawn_player(spawn_point)
	
func _on_hit_box_body_entered(body: Node2D) -> void:
	#print_debug("NAME:" + str(body.name))
	if body.is_in_group("Damage_Layer"):
		take_damage(1)
		
	
#Respawn
func set_checkpoint(pos):
	spawn_point = pos


func spawn_player(spawn_point: Vector2):
	global_position = spawn_point
	velocity = Vector2.ZERO
	health = max_health  
	
