extends Node2D
class_name Lever

var isLeft = true
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var player : Player
@export var tt: RichTextLabel
var player_in_area: bool = false
signal changed(is_left)
@onready var click_sfx : AudioStreamPlayer = $"Click"

func _ready() -> void:
	setup.call_deferred()
	tt.visible = false
	anim.play("lever_switch_to_left")
	anim.frame = 4

func setup():
	player = get_tree().get_first_node_in_group("Player")
	player.player_death.connect(reset_lever)

func _process(_delta) -> void:
	if player_in_area:
		tt.visible = true
	else:
		tt.visible = false
	if player_in_area and Input.is_action_just_pressed("interact") && not anim.is_playing():
		_toggle_lever(true, false)

func _toggle_lever(sfx: bool, instant: bool):
	if !isLeft:
		isLeft = true
		anim.play("lever_switch_to_left")
		if instant:
			anim.frame = 4
		if sfx:
			click_sfx.pitch_scale = 0.22
			click_sfx.play()
	else:
		isLeft = false
		anim.play("lever_switch_to_right")
		if instant:
			anim.frame = 4
		if sfx:
			click_sfx.pitch_scale = 0.2
			click_sfx.play()
	changed.emit(isLeft)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
	if body.is_in_group("Projectile") and !anim.is_playing():
		_toggle_lever(true, false)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
		
func reset_lever():
	isLeft = true
	changed.emit(isLeft)
