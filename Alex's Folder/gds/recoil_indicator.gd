extends Sprite2D

@onready var player = get_parent()
@export var controller: bool
@onready var sm = $"../StateMachine"
@onready var tween
@export var charge_c: Color = Color("fff2f1e3")
@export var no_charge_c: Color = Color("ba577a55")
@export var charge_c_time: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_joy_connection_changed)
	if Input.get_connected_joypads() != []:
		controller = true
	else: 
		controller = false
	pass # Replace with function body.

func _joy_connection_changed(device: int, connected: bool):
	if Input.get_connected_joypads() != []:
		controller = true
	else: 
		controller = false
	pass

func _input(InputEvent) -> void:
	if InputEvent is InputEventKey || InputEvent is InputEventMouse:
		controller = false
	elif InputEvent is InputEventJoypadButton || InputEvent is InputEventJoypadMotion:
		controller = true

func safe_tween(s, v, t):
	if tween != null:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, s, v, t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if sm.current_state.state_name == "cutscene" && modulate.a != 0:
		if tween != null:
			if tween.is_running():
				#NO
				pass
			else:
				#YES
				#print("SETTING TRANSPARENT")
				safe_tween("modulate:a", 0, 2)
		elif tween == null:
			#YES
			#print("SETTING TRANSPARENT")
			safe_tween("modulate:a", 0, 2)
		
	elif sm.current_state.state_name != "cutscene" && modulate.a == 0:
		if tween != null:
			if tween.is_running():
				#NO
				pass
			else:
				#YES
				#print("SETTING OPAQUE")
				safe_tween("modulate:a", charge_c.a, 2)
		elif tween == null:
			#YES
			#print("SETTING OPAQUE")
			safe_tween("modulate:a", charge_c.a, 2)
	
	elif player.collected_objects > 0 && sm.current_state.state_name != "cutscene":
		if !rgb_compare(charge_c, modulate) || modulate.a != charge_c.a:
			if tween != null:
				if tween.is_running():
					#NO
					pass
				else:
					#YES
					#print("SETTING CHARGE")
					safe_tween("modulate", charge_c, charge_c_time)
			elif tween == null:
				#YES
				#print("SETTING CHARGE")
				safe_tween("modulate", charge_c, charge_c_time)

	elif player.collected_objects == 0 &&  sm.current_state.state_name != "cutscene":
		if!rgb_compare(no_charge_c, modulate) || modulate.a != no_charge_c.a:
			if tween != null:
				if tween.is_running():
					#NO
					pass
				else:
					#YES
					#print("SETTING NO CHARGE")
					safe_tween("modulate", no_charge_c, charge_c_time)
			elif tween == null:
				#YES
				#print("SETTING NO CHARGE")
				safe_tween("modulate", no_charge_c, charge_c_time)

	if Input.is_action_just_pressed("fire_projectile") && controller == true:
		#print("switched to mouse")
		controller = false
	elif Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if controller == false:
			#print("switched to controller")
			controller = true
	var v 
	
	if !controller:
		if player.r_calc == player.recoil_calculation_type.from_player:
			v = (player.get_global_mouse_position() - player.position).normalized()
		elif player.r_calc == player.recoil_calculation_type.from_center_of_screen:
			v = (get_viewport().get_mouse_position() - Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)).normalized()
			pass
	elif controller:
		if Input.is_action_pressed("recoil_left") || Input.is_action_pressed("recoil_right") || Input.is_action_pressed("recoil_up") || Input.is_action_pressed("recoil_down"):
			v = Input.get_vector("recoil_left","recoil_right","recoil_up","recoil_down")
		pass
	if v != null:
		rotation = v.angle() + deg_to_rad(90)
	pass

func rgb_compare(a: Color, b: Color) -> bool:
	var i = 0
	if a.r == b.r:
		i = i+1
	if a.g == b.g:
		i = i+1
	if a.b == b.b:
		i = i+1
	
	if i == 3:
		return true
	else:
		return false
	

func wait(duration):
	await get_tree().create_timer(duration).timeout
