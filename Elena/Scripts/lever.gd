extends Node2D
var state = "left"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player : Player
@export var tt: RichTextLabel

var player_in_area: bool = false
signal changed(new_state)

@onready var click_sfx : AudioStreamPlayer = $"Click"

func _ready() -> void:
	if get_tree().get_first_node_in_group("Req") != null:
		player = get_tree().get_first_node_in_group("Player")
	else:
		player = $"../Player"
	tt.visible = false
	
	if state == "left":
		anim.play("lever_switch_to_left")
		anim.frame = 4
	elif state == "right":
		anim.play("lever_switch_to_right")
		anim.frame = 4
		

func _process(_delta) -> void:
	
	if player != null:
		if not player.player_death.is_connected(_on_player_death):
			player.player_death.connect(_on_player_death)
	
	if player_in_area:
		tt.visible = true
	else:
		tt.visible = false
	
	if player_in_area and Input.is_action_just_pressed("interact"):
		_toggle_lever(true, false)
	
	#Connect player death to reset lever
	if player != null:
		if not player.player_death.is_connected(reset_lever):
			player.player_death.connect(reset_lever)
	else:
		if get_tree().get_first_node_in_group("Req") != null:
			player = get_tree().get_first_node_in_group("Player")
		else:
			player = $"../Player"
	
func _toggle_lever(sfx: bool, instant: bool):
	if state == "right":
		state = "left"
		anim.play("lever_switch_to_left")
		if instant:
			anim.frame = 4
		if sfx:
			click_sfx.pitch_scale = 0.22
			click_sfx.play()
		print("lever: state=left")
		changed.emit(state)
		
	elif state == "left":
		state = "right" 
		anim.play("lever_switch_to_right")
		if instant:
			anim.frame = 4
		if sfx:
			click_sfx.pitch_scale = 0.2
			click_sfx.play()
		print("lever: state=right")
		changed.emit(state)

func _on_player_death():
	if state == "right":
		_toggle_lever(false, true)
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
		
func reset_lever():
	state = "left"
	changed.emit(state)
