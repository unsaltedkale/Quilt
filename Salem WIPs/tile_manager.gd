extends Node2D

@onready var magic_particle = preload("res://Alex's Folder/tscns/Tile Particle Effects/magical_barrier_particle.tscn")
@onready var unmagic_particle = preload("res://Alex's Folder/tscns/Tile Particle Effects/unmagical_barrier_particle.tscn")
@onready var mirror_particle = preload("res://Alex's Folder/tscns/Tile Particle Effects/mirror_particle.tscn")
@onready var break_particle = preload("res://Salem WIPs/breakable_tile_particle.tscn")

func _ready():
	setup_particles.call_deferred()


func setup_particles():
	for layer : TileMapLayer in get_children():
		var particle = null
		if layer.is_in_group("Magical_Barrier"): particle = magic_particle
		if layer.is_in_group("Unmagical_Barrier"): particle = unmagic_particle
		if layer.is_in_group("Mirror"): particle = mirror_particle
		if layer.is_in_group("Breakable_Layer"): particle = break_particle
		if particle != null:
			for cell_index in layer.get_used_cells():
				var local_cell_position : Vector2 = layer.map_to_local(cell_index)
				#var global_cell_position : Vector2 = layer.to_global(cell_index)
				var new_particle : CPUParticles2D = particle.instantiate()
				new_particle.position = local_cell_position
				new_particle.scale = Vector2(1.0/layer.scale.x,1.0/layer.scale.y) #Makes particles adjust to tile map layer scale
				layer.add_child(new_particle)
				if particle == break_particle:
					var area : BreakableArea = layer.get_child(0)
					area.particles.append(particle)
