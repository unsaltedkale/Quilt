extends Area2D

@onready var ray = $RayCast2D
@export var speed : Vector2
var projectile_direction: Vector2 
const sfx_end = preload("res://Resources/SFX/Quilt Character SFX/fireball end.wav")

func _ready() -> void:
	ray.enabled = true
	ray.target_position = Vector2(20,0)
	await get_tree().create_timer(10).timeout
	print("timed out")
	queue_free()

func _process(_delta):
	$Sprite2D.play("FIRE")

	
func _physics_process(delta) -> void:
	rotation = projectile_direction.angle()
	position += projectile_direction * speed * delta
	
	if ray.is_colliding():
		var collider = ray.get_collider()

		if collider and collider.is_in_group("Mirror"):
			var normal = ray.get_collision_normal()
			projectile_direction = projectile_direction.bounce(normal)
			ray.target_position = Vector2(20,0)
			ray.force_raycast_update()
				
func _on_projectile_entered(body:Node2D):
	if body.is_in_group("tilemap"):
		_play_extinguish_sound()
		queue_free()
		
func _on_area_entered(body: Area2D):
	if body.is_in_group("Stasis"):
		#_play_extinguish_sound() dont play sound because it will clash with stasis sfx
		if body.timer <= 0: #if the player wasn't just in this stasis chamber
			queue_free()

func _play_extinguish_sound():
	var sound = AudioStreamPlayer.new()
	sound.finished.connect(sound.queue_free)
	sound.stream = sfx_end
	get_tree().current_scene.add_child(sound)
	sound.play(0.33)
	
