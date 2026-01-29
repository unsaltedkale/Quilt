extends Node

var checkpoint_position: Vector2

func save_checkpoint(pos: Vector2):
	checkpoint_position = pos
	print("Checkpoint saved at:", pos)
	
func respawn_player(player: Node2D):
	if checkpoint_position:
		player.global_posistion = checkpoint_position
	
		
