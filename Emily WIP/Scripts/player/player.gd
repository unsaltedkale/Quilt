extends CharacterBody2D

class_name Player

# On Readys
@onready var quilt_collider: CollisionShape2D = $QuiltCollider
@onready var quilt_crouch: CollisionShape2D = $QuiltCrouch
@onready var quilt_uncrouch_check: Area2D = $QuiltUncrouchCheck
@onready var force_crouch: bool = false
@onready var reset_ttm = $"Reset Confirmation TTM"
@onready var reset_square = $"Reseting Indicator"

# Exported variables (all should be able to go into player res script)
@export var is_phlo: bool = false
@export var r_calc: recoil_calculation_type

# Const
const PLAYER_DATA = preload("uid://c33m5ti1y2ang")

# Bools
var shrine_key: bool = false
var crouch_speed : bool
var start_wump : bool
var no_recoil : bool
var confirming_reset: bool

# Floats

var reset_timer: float

# Ints
var collected_objects: int
var health: int
var jump_count : int

# Vector2s
var spawn_point
var reset_square_max = Vector2(5,5)

# what is this, can we make better?
var current_stasis = null #Replaces is_stasis: we need to know which stasis chamber we're in to teleport to the right one

# enums
enum recoil_calculation_type {from_player, from_center_of_screen}

# Signals
signal player_death



func _ready() -> void:
	health = PLAYER_DATA.max_health
	spawn_point = global_position
	no_recoil = false
	
	reset_timer = PLAYER_DATA.reset_timer_max
	reset_ttm.visible = false
	reset_square.scale = Vector2(0,0)
	confirming_reset = false

func _process(_delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if is_on_floor():
		jump_count = 0
	
	# RESET INPUT HANDLING
	
	if $StateMachine.current_state.name != "cutscene":
		
		if not confirming_reset:
			
			#COUNTING SECONDS
			
			if Input.is_action_pressed("reset"):
				reset_timer -= _delta
				
				if reset_square_max > reset_square.scale:
					reset_square.scale += (reset_square_max / PLAYER_DATA.reset_timer_max) * _delta
				
				if reset_timer <= 0:
					confirming_reset = true
					reset_ttm.visible = true
				pass
			
			else:
				reset_timer = PLAYER_DATA.reset_timer_max
				reset_ttm.visible = false
				if 0 < reset_square.scale.x:
					reset_square.scale -= 5*(reset_square_max / PLAYER_DATA.reset_timer_max) * _delta
				if 0.01 > reset_square.scale.x:
					reset_square.scale = Vector2(0,0)
					
				pass
		
		elif confirming_reset:
			
			# press one more time to confirm.
			
			if Input.is_action_just_pressed("reset"):
				
				#kill player!!!!
				reset_ttm.visible = false
				confirming_reset = false
				reset_timer = PLAYER_DATA.reset_timer_max
				take_damage(100)
				pass
			
			# press anything else to reset.
			
			var b
			
			var InputMapList: Array = InputMap.get_actions()
			
			for actions in InputMapList:
				if Input.is_action_just_pressed(actions):
					b = true
				
			if b == true:
				
				if not Input.is_action_pressed("reset"):
					confirming_reset = false
					reset_timer = PLAYER_DATA.reset_timer_max
					reset_ttm.visible = false
				pass
			
			pass
			
	else:
		
		#no die during cutscene!!!
		
		reset_ttm.visible = false
		reset_timer = PLAYER_DATA.reset_timer_max
		
		if 0 < reset_square.scale.x:
			reset_square.transform -= 5*(reset_square_max / PLAYER_DATA.reset_timer_max) * _delta
		if 0.01 > reset_square.scale.x:
			reset_square.scale = Vector2(0,0)
		pass
	
	pass

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
		
		#wouldn't you want to reset health here...? -- alex 5/7/2026
		
		# set bool for death to true, don't want animations besides death to play
	#allows for different damage amounts if we ever want to do that

func die():
	#print_debug("Player died")
	$"../Camera2D".player_died()
	player_death.emit()
	current_stasis = null #Make sure ziplines don't trap us when we die
	spawn_player()

func _on_quilt_collider_non_physics_body_entered(body: Node2D) -> void:
	if body.is_in_group("Damage_Layer"):
		take_damage(1)
	if body.name == "Unmagical_Barrier" || body.get_groups().has("Unmagical_Barrier"):
		no_recoil = true
	#if this collider is disabled: pass
	pass

func _on_quilt_body_exited(body: Node2D):
	if body.name == "Unmagical_Barrier" || body.get_groups().has("Unmagical_Barrier"):
		no_recoil = false
	#if this collider is disabled: pass

func _on_phlo_body_entered(body: Node2D):
	if body.is_in_group("Damage_Layer"):
		take_damage(1)
	#if this collider is disabled: pass


#CROUCH
# This can stay, only quilt, could change if there is a way to get upper half of a collider
func _on_quilt_uncrouch_check_body_entered(body: Node2D) -> void:
	if body.name == "Collision" || body.name == "Magical_Barrier" || body.name == "Damage_Layer" || body.name == "Mirror":
		#print_debug("ENTERED:" + str(body.name))
		_quilt_uncrouch_check_changed(true)
	
	pass # Replace with function body.

func _on_quilt_uncrouch_check_body_exited(body: Node2D) -> void:
	
	if body.name == "Collision" || body.name == "Magical_Barrier" || body.name == "Damage_Layer" || body.name == "Mirror":
		#print_debug("EXITED:" + str(body.name))
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
			#print("force_uncrouching")
			#player does not want to crouch and can uncrouch-- uncrouch them
			$StateMachine/Idle._force_leave_crouch()
			force_crouch = false

#RESPAWN
func set_checkpoint(pos):
	spawn_point = pos

func spawn_player(): #someone needs to check out the warning message here
	global_position = spawn_point
	velocity = Vector2.ZERO
	health = PLAYER_DATA.max_health

func change_player(_player: int) -> void:
	pass
