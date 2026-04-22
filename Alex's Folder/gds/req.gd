extends Node2D

enum req_type {staging, prod}

@export var a: req_type = req_type.staging

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if a == req_type.staging:
		if get_tree().get_nodes_in_group("Req").size() > 1:
			print("REQ STAGING OF " + get_parent().name + " IN PROD, SELF DESTRUCTING!")
			queue_free()
		pass
	pass
