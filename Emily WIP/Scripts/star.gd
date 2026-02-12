extends Area2D
@export_subgroup("Settings")
@export var respawns: bool
@export var respawn_timer_max = 3
var respawn_timer

func _ready():
	respawn_timer = respawn_timer_max

func _process(delta: float) -> void:
	if find_child("Sprite2D").visible == false && respawns == true:
		respawn_timer -= delta

		if respawn_timer <= 0:
			find_child("Sprite2D").visible = true
			find_child("CollisionShape2D").set_deferred("disabled", false)
			respawn_timer = respawn_timer_max

func _on_STAR_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && find_child("CollisionShape2D").disabled == false:
		print("collected a star")
		if body.collected_objects < body.max_stars:
			body.collected_objects += 1
		find_child("Sprite2D").visible = false
		find_child("CollisionShape2D").set_deferred("disabled", true)
		
