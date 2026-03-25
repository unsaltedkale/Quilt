extends Sprite2D

@onready var player = get_parent()
@export var controller: bool
@onready var sm = $"../StateMachine"
@onready var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_joy_connection_changed)
	if Input.get_connected_joypads() != []:
		controller = true
	else: 
		controller = false
	print(Input.get_connected_joypads())
	pass # Replace with function body.

func _joy_connection_changed(device: int, connected: bool):
	if Input.get_connected_joypads() != []:
		controller = true
	else: 
		controller = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if sm.current_state.state_name == "cutscene" && modulate.a == 1:
		print("SETTING TRANSPARENT")
		if tween != null:
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0, 2)
		
	elif sm.current_state.state_name != "cutscene" && modulate.a == 0:
		print("SETTING OPAQUE")
		if tween != null:
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 1, 2)

	if Input.is_action_just_pressed("fire_projectile") && controller == true:
		print("switched to mouse")
		controller = false
	elif Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		if controller == false:
			print("switched to controller")
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

func wait(duration):
	await get_tree().create_timer(duration).timeout
