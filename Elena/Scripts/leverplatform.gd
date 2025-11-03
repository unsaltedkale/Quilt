extends AnimatableBody2D

@export var lever_path: NodePath
@export var point_a: Vector2
@export var point_b: Vector2
@export var move_speed: float = 2.0

var lever: Node = null
var target_position: Vector2

func _ready() -> void:
	if lever_path:
		var node = get_node(lever_path)

		if "state" in node:
			lever = node
		else:
			for child in node.get_children():
				if "state" in child:
					lever = child
					break
	else:
		push_error("Lever path not set for moving platform!")
		return
	
	if lever == null:
		push_error("No valid lever found with 'state' property at lever_path.")
		return

	update_target_from_lever()

	# Connect to lever's signal if it exists
	if lever.has_signal("state_changed"):
		lever.connect("state_changed", Callable(self, "_on_lever_state_changed"))

func _physics_process(delta: float) -> void:
	# Smoothly move toward the target
	global_position = global_position.lerp(target_position, move_speed * delta)

func _on_lever_state_changed(new_state: String) -> void:
	update_target_from_lever()

func update_target_from_lever() -> void:
	if lever == null:
		return
	
	var current_state = lever.get("state") if "state" in lever else null
	if current_state == "left":
		target_position = point_a
	elif current_state == "right":
		target_position = point_b
