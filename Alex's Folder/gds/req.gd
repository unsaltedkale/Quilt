extends Node2D

enum req_type {staging, prod}

@export var a: req_type = req_type.staging
@export var has_set_tile_particles: bool = false

@onready var mb_p = preload("res://Alex's Folder/tscns/Tile Particle Effects/magical_barrier_particle.tscn")
@onready var umb_p = preload("res://Alex's Folder/tscns/Tile Particle Effects/unmagical_barrier_particle.tscn")
@onready var mir_p = preload("res://Alex's Folder/tscns/Tile Particle Effects/mirror_particle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if a == req_type.staging:
		if get_tree().get_nodes_in_group("Req").size() > 1:
			print("REQ STAGING OF " + get_parent().name + " IN PROD, SELF DESTRUCTING!")
			queue_free()
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if a == req_type.staging:
		if get_tree().get_nodes_in_group("Req").size() > 1:
			print("REQ STAGING OF " + get_parent().name + " IN PROD, SELF DESTRUCTING!")
			queue_free()
		pass 
	
	else:
		if has_set_tile_particles == false:
			_set_tile_particles()
			has_set_tile_particles = true
				
		pass
	
func _set_tile_particles() -> void:
	
	if get_tree().get_first_node_in_group("Req").a == req_type.staging:
		
		var tiles = $"../Tiles"
		print("setting...")
		for tml in tiles.get_children():
			
			var p = null
			
			match tml.name:
				"Magical_Barrier":
					p = mb_p
				"Unmagical_Barrier":
					p = umb_p
				"Mirror":
					p = mir_p
			
			'''print(tml.get_children())
			
			if tml.find_child("breakable_area") != null:
				print("BA FOUND -----------------------")
				p = mb_p'''
			
			if p != null:
				for v in tml.get_used_cells():
					
					var localCellPosition = tml.map_to_local(v)
					var globalCellPosition = tml.to_global(localCellPosition)
					
					var part = p.instantiate()
					part.position = globalCellPosition
					get_tree().current_scene.add_child(part)
					pass
			pass
	
	elif get_tree().get_first_node_in_group("Req").a == req_type.prod:
		
		for vinnie in get_parent().get_children():
			
			if vinnie.is_in_group("Req"):
				pass
			elif vinnie.find_child("Tiles") != null:
				var tiles = vinnie.find_child("Tiles")
				
				print(vinnie)
				
				print("setting...")
				
				for tml in tiles.get_children():
					
					var p = null
					
					match tml.name:
						"Magical_Barrier":
							p = mb_p
						"Unmagical_Barrier":
							p = umb_p
						"Mirror":
							p = mir_p
					
					if p != null:
						for v in tml.get_used_cells():
							
							var localCellPosition = tml.map_to_local(v)
							var globalCellPosition = tml.to_global(localCellPosition)
							
							var part = p.instantiate()
							part.position = globalCellPosition
							get_tree().current_scene.add_child(part)
							pass
					pass
	pass
