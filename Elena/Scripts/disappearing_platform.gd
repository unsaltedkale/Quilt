extends RigidBody2D

@onready var player = $"../Player"
@onready var start_position
@onready var start_rotation
@export var time: float


func _ready() -> void:
	
	self.gravity_scale = 0
	start_position = global_position
	start_rotation = rotation
	
	

func _process(_delta: float) -> void:
	player.player_death.connect(reset_platforms)
	#if player == null:
		#if get_tree().root.get_child(0).find_child("Req") != null:
			#player = get_tree().root.get_child(0).find_child("Req").find_child("Player")
			#print(player)
			#
		#elif get_tree().root.find_child("Player") != null:
			#player = $"../Player"
	
	
func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			await get_tree().create_timer(time).timeout
			self.gravity_scale = 1
			
func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.take_damage(1)
		in_holding()
		
		
	if body.is_in_group("tilemap"):
		in_holding()

func in_holding():
	self.modulate = 0
	$DeathArea/DeathCollision.set_deferred("disabled", true)
	set_collision_layer_value(1, false)
	

func reset_platforms():
	self.modulate = 1
	print("platforms respawning")
	self.gravity_scale = 0
	global_position = start_position
	
	
