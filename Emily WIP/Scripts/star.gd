extends Area2D
@export_subgroup("Settings")
@export var respawns: bool = true
@export var respawn_timer_max : float = 3.0
var respawn_timer
@onready var player: Node2D

@onready var active_sprite = load("res://Art/Quilt STAR-1.png")
@onready var inactive_sprite = load("res://Art/Quilt STAR-2.png")

@onready var collect_star_sfx : AudioStreamPlayer = $"Collect Star"
@onready var respawn_star_sfx : AudioStreamPlayer = $"Star Respawn"

func _ready():
	respawn_timer = respawn_timer_max
	active_sprite = load("res://Art/Quilt STAR-1.png")
	inactive_sprite = load("res://Art/Quilt STAR-2.png")
	find_child("Sprite2D").texture = active_sprite
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	
	if player != null:
		if get_overlapping_areas().has(player.find_child("Area2D")):
			_on_STAR_entered(player)
	else:
		player = get_tree().get_first_node_in_group("Player")
	if respawns == true && find_child("Sprite2D").texture == inactive_sprite:
		respawn_timer =  respawn_timer - delta
		#print(str(respawn_timer) + " / " + str(get_path()))

	if respawn_timer <= 1.5 && !respawn_star_sfx.playing:
		respawn_star_sfx.play()
	if respawn_timer <= 0 && respawns == true:
		#print("RESPAWN" + str(get_path()))
		find_child("Sprite2D").texture = active_sprite
		find_child("CollisionShape2D").set_deferred("disabled", false)
		respawn_timer = respawn_timer_max

func _on_STAR_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && find_child("Sprite2D").texture == active_sprite:
		if body.collected_objects < body.max_objects:
			body.collected_objects += 1
			find_child("Sprite2D").texture = inactive_sprite
			find_child("CollisionShape2D").set_deferred("disabled", true)
			collect_star_sfx.play()
