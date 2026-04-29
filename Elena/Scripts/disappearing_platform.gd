extends StaticBody2D

var player
var start_position: Vector2
var start_rotation: float
@export var time: float = 3.0

@onready var timer : Timer = $"Timer"

@onready var crumble_sfx : AudioStreamPlayer = $"Crumbling"

func _ready() -> void:
	
	if get_tree().get_first_node_in_group("Req") != null:
		player = get_tree().get_first_node_in_group("Player")
	else:
		player = $"../Player"
	
	start_position = global_position
	start_rotation = rotation
	timer.wait_time = time

func _process(_delta: float) -> void:
	if player != null:
		if not player.player_death.is_connected(reset_platforms):
			player.player_death.connect(reset_platforms)
	else:
		if get_tree().get_first_node_in_group("Req") != null:
			player = get_tree().get_first_node_in_group("Player")
		else:
			player = $"../Player"
	
	#make the sfx fade out so it's basically gone by the time the platform disappears
	if !timer.is_stopped(): crumble_sfx.volume_linear = 0.5 * (timer.time_left / time) ** 2


func _on_timer_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player") && timer.is_stopped():
			timer.start()
			crumble_sfx.play()
			#playanimationforplatformbreaking?


func reset_platforms():
		timer.stop()
		timer.timeout.emit()
		global_position = start_position
		rotation = start_rotation
		self.modulate.a = 1
		set_collision_layer_value(1, true)


func _on_timer_timeout() -> void:
	set_collision_layer_value(1, false)
	self.modulate.a = 0
	crumble_sfx.stop()
