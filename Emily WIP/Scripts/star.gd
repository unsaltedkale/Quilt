extends Area2D
@export_subgroup("Settings")
@export var respawns: bool
@export var respawn_timer_max = 3
var respawn_timer

@onready var active_sprite = load("res://Art/Quilt STAR-1.png")
@onready var inactive_sprite = load("res://Art/Quilt STAR-2.png")

func _ready():
	respawn_timer = respawn_timer_max
	inactive_sprite = load("res://Art/Quilt STAR-2.png")

func _process(delta: float) -> void:
	if find_child("CollisionShape2D").disabled == true && respawns == true:
		respawn_timer -= delta

		if respawn_timer <= 0:
			find_child("Sprite2D").texture = active_sprite
			find_child("CollisionShape2D").set_deferred("disabled", false)
			respawn_timer = respawn_timer_max

func _on_STAR_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && find_child("CollisionShape2D").disabled == false && find_child("Sprite2D").texture == active_sprite:
		print("collected a star")
		if body.collected_objects < body.max_objects:
			body.collected_objects += 1
		find_child("Sprite2D").texture = inactive_sprite
		find_child("CollisionShape2D").set_deferred("disabled", true)
		
