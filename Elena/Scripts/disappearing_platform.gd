extends RigidBody2D

@onready var player
@onready var start_position
@onready var start_rotation
@export var time: float

func _ready() -> void:
	
	if get_tree().get_first_node_in_group("Req") != null:
		player = get_tree().get_first_node_in_group("Player")
	else:
		player = $"../Player"
	
	self.gravity_scale = 0
	start_position = global_position
	start_rotation = rotation
	
	

func _process(_delta: float) -> void:
	if player != null:
		if not player.player_death.is_connected(reset_platforms):
			player.player_death.connect(reset_platforms)
	#if player == null:
		#if get_tree().root.get_child(0).find_child("Req") != null:
			#player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
			#print(player)
			#
		#elif get_tree().root.find_child("Player") != null:
			#player = $"../Player"
	else:
		if get_tree().get_first_node_in_group("Req") != null:
			player = get_tree().get_first_node_in_group("Player")
		else:
			player = $"../Player"
		
	
func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			await get_tree().create_timer(time).timeout
			self.gravity_scale = 1
			
func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.take_damage(1)
		self.modulate.a = 0
		$DeathArea/DeathCollision.set_deferred("disabled", true)
		set_collision_layer_value(1, false)
		
		
	if body.is_in_group("tilemap"):
		self.modulate.a = 0
		$DeathArea/DeathCollision.set_deferred("disabled", true)
		set_collision_layer_value(1, false)


func reset_platforms():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	gravity_scale = 0
	global_position = start_position
	rotation = start_rotation
	self.modulate.a = 1
	set_collision_layer_value(1, true)
	$DeathArea/DeathCollision.set_deferred("disabled", false)
	
	
	
	
	
