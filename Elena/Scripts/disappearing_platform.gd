extends StaticBody2D

var player
var start_position: Vector2
var start_rotation: float
@export var time: float

var timer : SceneTreeTimer

func _ready() -> void:
	
	if get_tree().get_first_node_in_group("Req") != null:
		player = get_tree().get_first_node_in_group("Player")
	else:
		player = $"../Player"
	
	start_position = global_position
	start_rotation = rotation
	

func _process(_delta: float) -> void:
	if player != null:
		if not player.player_death.is_connected(reset_platforms):
			player.player_death.connect(reset_platforms)
	else:
		if get_tree().get_first_node_in_group("Req") != null:
			player = get_tree().get_first_node_in_group("Player")
		else:
			player = $"../Player"
		
	
func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			timer = get_tree().create_timer(time)
			await timer.timeout
			set_collision_layer_value(1, false)
			self.modulate.a = 0
			#playanimationforplatformbreaking?
		
func reset_platforms():
		if timer != null: timer.timeout.emit()
		global_position = start_position
		rotation = start_rotation
		self.modulate.a = 1
		set_collision_layer_value(1, true)
		
	
	
	
	
	
