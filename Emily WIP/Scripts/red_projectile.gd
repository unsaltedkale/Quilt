extends Area2D

@export var speed : Vector2
var projectile_direction


func _process(_delta):
	$Sprite2D.play("FIRE")
	
func _physics_process(delta) -> void:
	rotation = projectile_direction.angle()
	position += projectile_direction * speed * delta
		
func _on_projectile_entered(body:Node2D):
	if body.is_in_group("tilemap"):
		queue_free()
		
func _on_area_entered(body: Area2D):
	if body.is_in_group("Stasis"):
		queue_free()

func _play_extinguish_sound():
	var sound = AudioStreamPlayer.new()
	sound.finished.connect(sound.queue_free)
	#TODO: Load fireball end sound effect
	get_tree().current_scene.add_child(sound)
