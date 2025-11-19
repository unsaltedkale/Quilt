extends AnimatableBody2D

@export var bar_appear = 0
@export var beat_appear = 0
@export var bar_delete = 0
@export var beat_delete = 0
@onready var Conductor = $"../Conductor"

func _ready():
	get_node("CollisionShape2D").disabled = true
	visible = false
	pass
	
func _physics_process(delta):
	if Conductor != null:
		if Conductor.barnumber != null or Conductor.beatnumber != null:
			if bar_appear == Conductor.barnumber and beat_appear == Conductor.beatnumber and get_node("CollisionShape2D").disabled == true:
				get_node("CollisionShape2D").disabled = false
				visible = true
			if bar_delete == Conductor.barnumber and beat_delete == Conductor.beatnumber and get_node("CollisionShape2D").disabled == false:
				get_node("CollisionShape2D").disabled = true
				visible = false
