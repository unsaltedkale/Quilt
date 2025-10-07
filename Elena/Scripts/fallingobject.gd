extends RigidBody2D

@export var damage: int = 10
@export var break_effect_scene: PackedScene

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
	
	elif body.is_in_group("Ground") or body is TileMapLayer:
		# For TileMap, we might want to check tile type optionally
		if body is TileMapLayer:
			# Optionally, check tile at contact point (not mandatory)
			var tile_pos = body.world_to_map(global_position)
			var tile_id = body.get_cell(tile_pos.x, tile_pos.y)
			# If tile_id != -1 (means a tile is there), break
			if tile_id != -1:
				_break_object()
		else:
			# Ground node, break directly
			_break_object()

func _break_object():
	if break_effect_scene:
		var effect = break_effect_scene.instantiate()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
	queue_free()
