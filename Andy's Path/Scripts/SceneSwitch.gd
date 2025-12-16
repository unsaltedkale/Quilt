extends Area2D

@export var Scene: String

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player") and Scene != null:
		get_tree().change_scene_to_file(Scene)
	else:
		print("No Scene found (check in the insector of the SceneSwitch Area2D)")
