extends Node

var checkpoints = []
var uncollected_checkpoints = []
var uncollected_checkpoint_index = []

func _ready() -> void:
	checkpoints = get_tree().get_nodes_in_group("Checkpoints")
	for i in range(len(checkpoints)):
		uncollected_checkpoints.append(checkpoints[i])
		uncollected_checkpoint_index.append(checkpoints[i].checkpoint_index)

func _process(delta: float) -> void:
	for i in range(uncollected_checkpoints.size()):
		if uncollected_checkpoints[i].active:
			uncollected_checkpoints.remove_at(i)
	print(uncollected_checkpoints)
