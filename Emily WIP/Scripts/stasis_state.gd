extends State
class_name Stasis

var tooltip_timer: float
var tooltip_timer_max: float = 0.7 
@export var tt: RichTextLabel
var fade_speed = 1

func Enter(previous_state: State):
	
	_force_leave_crouch()
	
	player.velocity = Vector2(0,0)
	
	tt.visible = false
	tooltip_timer = tooltip_timer_max

func Physics_Update(_delta):
	
	print(tooltip_timer)
	
	if not tt.visible:
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
			
			tooltip_timer -= _delta
			if tooltip_timer < 0:
				tt.visible = true
				tt.modulate = Color(1,1,1,1.5)
		
	elif tt.visible:
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
			tooltip_timer -= _delta
			if tooltip_timer <= 0:
				tt.modulate.a = 1.5
		elif tt.modulate.a > 0:
			tt.modulate.a -= _delta * fade_speed
		elif tt.modulate.a <= 0:
			tooltip_timer = 0.3

	
		
	if Input.is_action_just_pressed("fire_projectile") || Input.is_action_just_pressed("recoil_left") || Input.is_action_just_pressed("recoil_right") || Input.is_action_just_pressed("recoil_up") || Input.is_action_just_pressed("recoil_down"):
		player.current_stasis = null
		Transition.emit(self, "recoil")
	#Elliot wanted this, might delete later --Alex
	elif Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("crouch"):
			player.current_stasis = null
			Transition.emit(self, "idle")
		else:
			player.current_stasis = null
			Transition.emit(self, "jump")
	else:
		player.velocity = Vector2(0,0)

func Exit():
	tt.visible = false
