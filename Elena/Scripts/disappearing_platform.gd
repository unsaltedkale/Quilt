extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"
@onready var start_position
@onready var start_rotation



func _ready() -> void:
	#if get_tree().root.get_child(0).find_child("Req") != null:
		#player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
		#print(player)
	#elif get_tree().root.find_child("Player") != null:
		#player = $"../Player"
	
	self.gravity_scale = 0
	start_position = global_position
	start_rotation = rotation
	
	if player:
		player.player_death.connect(reset_platforms)

func _process(_delta: float) -> void:
	pass
	
	#if player == null:
		#if get_tree().root.get_child(0).find_child("Req") != null:
			#player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
			#print(player)
		#elif get_tree().root.find_child("Player") != null:
			#player = $"../Player"
			
func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			$Timer.start()

func _on_timer_timeout() -> void:
	self.gravity_scale = 1
	$Timer.stop()
	#animation or sprite change so it appears as crumbling/pieces when its falling? assuming we want something better than just the block plummenting to the ground

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.take_damage(1)
		in_holding()
		
	if body.is_in_group("tilemap"):
		in_holding()

func in_holding():
	self.modulate.a = 0
	$DeathArea/DeathCollision.set_deferred("disabled", true)
	set_collision_layer_value(1, false)
	set_deferred("freeze", true)

func reset_platforms():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	global_position = start_position
	rotation = start_rotation
	self.gravity_scale = 0
	self.modulate.a = 1
	$DeathArea/DeathCollision.set_deferred("disabled", false)
	set_collision_layer_value(1, true)
