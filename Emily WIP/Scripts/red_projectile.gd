extends CharacterBody2D

@export var speed : float = 800.0
var projectile_direction: Vector2 = Vector2.RIGHT 

const sfx_end = preload("res://Resources/SFX/Quilt Character SFX/fireball end.wav")

func _ready() -> void:
	velocity = projectile_direction * speed
	await get_tree().create_timer(10).timeout
	queue_free()

func _process(_delta):
	$Sprite2D.play("FIRE")
	
func _physics_process(delta) -> void:
	rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	  
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("mirror"):
			velocity = velocity.bounce(collision.get_normal())
			
		if collider.is_in_group("Player"):
			pass
			
		elif collider.is_in_group("tilemap"):
			_play_extinguish_sound()
			queue_free()
			

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("Stasis"):
		queue_free()

func _play_extinguish_sound():
	var sound = AudioStreamPlayer.new()
	sound.finished.connect(sound.queue_free)
	sound.stream = sfx_end
	get_tree().current_scene.add_child(sound)
	sound.play(0.33)
	
