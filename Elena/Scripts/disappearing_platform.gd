extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"
@onready var start_pos: Vector2 = global_position

func _ready() -> void:
	self.gravity_scale = 0
	
func _process(_delta: float) -> void:
	if player.player_has_died == 1:
		pass

func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			$Timer.start()

func _on_timer_timeout() -> void:
	self.gravity_scale = 1
	#animation or sprite change so it appears as crumbling/pieces when its falling? assuming we want something better than just the block plummenting to the ground

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.take_damage(1)
		in_holding()
		
	if body.is_in_group("tilemap"):
		in_holding()

func in_holding():
	self.modulate.a = 0
	$DeathArea/DeathCollision.disabled = true
	set_collision_layer_value(1, false)
