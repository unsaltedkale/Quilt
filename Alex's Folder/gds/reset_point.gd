extends Area2D

@onready var player
@export var timer_max = 2.0
@export var timer: float
@export var countdown: bool
@export var player_in_trigger: bool

@export var label: Label

@onready var placeholder_text: String

@export var original_position: Vector2
@export var inactive_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position
	inactive_position = original_position + Vector2(0, 12)
	position = inactive_position
	
	if get_tree().root.get_child(0).find_child("Req") != null:
		player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
	else:
		player = $"../Player"
	
	player_in_trigger = false
	placeholder_text = ""
	find_child("AnimatedSprite2D").play("unactive_checkpoint_2")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") && player_in_trigger:
		countdown = true
	if Input.is_action_just_released("interact") || not player_in_trigger:
		countdown = false
		timer = timer_max
		label.text = placeholder_text
		find_child("AnimatedSprite2D").play("unactive_checkpoint_2")
		position = inactive_position

	if countdown:
		timer -= delta
		label.text = str(snapped(timer, 0.1))
		if player.is_phlo:
			find_child("AnimatedSprite2D").play("active_checkpoint_red_2")
		else:
			find_child("AnimatedSprite2D").play("active_checkpoint_white_2")
		position = original_position
	
	if timer <= 0:
		player.die()
		timer = timer_max
		label.text = placeholder_text
		find_child("AnimatedSprite2D").play("unactive_checkpoint_2")
		position = inactive_position
		pass


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = true
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		player_in_trigger = false
	pass # Replace with function body.
