extends CharacterBody2D

class_name Player


@onready var quilt_collider: CollisionShape2D = $QuiltCollider
@onready var quilt_crouch: CollisionShape2D = $QuiltCrouch
@onready var quilt_uncrouch_check: Area2D = $QuiltUncrouchCheck
@onready var force_crouch: bool = false

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

var crouch_speed : bool
var start_wump : bool
var no_recoil : bool

func _ready() -> void:
	health = max_health
	spawn_point = global_position
	no_recoil = false

func _process(_delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if is_on_floor():
		jump_count = 0
	
	#print(no_recoil)
	
	
func _physics_process(_delta: float) -> void:
	
	#print(force_crouch)
	
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
	print_debug("NAME:" + str(body.name))
	if body.is_in_group("Damage_Layer"):
		take_damage(1)

func _on_area_entered(body: Area2D):
	#Unmagical barrier detection work with on area entered. must be body. for
	#SOME REASON?!?!?!?!
	pass
		
func _on_tile_map_check_body_entered(body: Node2D) -> void:
	print_debug("ENTERED:" + str(body.name))
	if body.name == "Unmagical_Barrier" || body.get_groups().has("Unmagical_Barrier"):
		no_recoil = true
	pass # Replace with function body.

func _on_tile_map_check_body_exited(body: Node2D) -> void:
	print_debug("EXITED:" + str(body.name))
	if body.name == "Unmagical_Barrier" || body.get_groups().has("Unmagical_Barrier"):
		no_recoil = false
	pass # Replace with function body.

func _on_quilt_uncrouch_check_body_entered(body: Node2D) -> void:
	if body.name == "Collision" || body.name == "Magical_Barrier" || body.name == "Damage_Layer" || body.name == "Mirror":
		print_debug("ENTERED:" + str(body.name))
		_quilt_uncrouch_check_changed(true)
	
	pass # Replace with function body.


func _on_quilt_uncrouch_check_body_exited(body: Node2D) -> void:
	
	if body.name == "Collision" || body.name == "Magical_Barrier" || body.name == "Damage_Layer" || body.name == "Mirror":
		print_debug("EXITED:" + str(body.name))
		_quilt_uncrouch_check_changed(false)
	pass # Replace with function body.


func _quilt_uncrouch_check_changed(b: bool):
	
	#b means if the area2D is hitting a tilemap it shouldn't be able to uncrouch into
	
	if b == false:
		# no collision, they can crouch if they want.
		force_crouch = false
	
	if b == true:
		force_crouch = true
	
	if quilt_crouch.disabled == false:
		#currently crouching
		
		if not Input.is_action_pressed("crouch") && not b:
			print("force_uncrouching")
			#player does not want to crouch and can uncrouch-- uncrouch them
			$StateMachine/Idle._force_leave_crouch()
			force_crouch = false
			

#Respawn
func set_checkpoint(pos):
	spawn_point = pos


func spawn_player(spawn_point: Vector2):
	global_position = spawn_point
	velocity = Vector2.ZERO
	health = max_health  


func change_player(player: int) -> void:
	pass
