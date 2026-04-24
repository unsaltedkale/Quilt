extends Area2D
@export_subgroup("Settings")
@export var respawns: bool = true
@export var respawn_timer_max : float = 3.0
var respawn_timer

@onready var active_sprite = load("res://Art/Quilt STAR-1.png")
@onready var inactive_sprite = load("res://Art/Quilt STAR-2.png")

func _ready():
	respawn_timer = respawn_timer_max
	active_sprite = load("res://Art/Quilt STAR-1.png")
	inactive_sprite = load("res://Art/Quilt STAR-2.png")
	find_child("Sprite2D").texture = active_sprite
	

func _process(delta: float) -> void:
	if respawns == true && find_child("Sprite2D").texture == inactive_sprite:
		respawn_timer =  respawn_timer - delta
		#print(str(respawn_timer) + " / " + str(get_path()))

	if respawn_timer <= 0 && respawns == true:
		#print("RESPAWN" + str(get_path()))
		find_child("Sprite2D").texture = active_sprite
		find_child("CollisionShape2D").set_deferred("disabled", false)
		respawn_timer = respawn_timer_max

func _on_STAR_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && find_child("Sprite2D").texture == active_sprite:
		if body.collected_objects == 0:
			print("collected a star")
			if body.collected_objects < body.max_objects:
				body.collected_objects += 1
			find_child("Sprite2D").texture = inactive_sprite
			find_child("CollisionShape2D").set_deferred("disabled", true)
		else:
			print("skipped")
		
