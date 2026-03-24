extends Path2D

@export var inc = 0
@export var speed = 400
@export var emit: bool
@export var process_emit: bool
@onready var spark = $PathFollow2D/Spark

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spark.emitting = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("crouch"):
		emit = true
	if emit == true:
		spark.emitting = true
		process_emit = true
		emit = false
		inc = 0
	if process_emit == true:
		inc+=delta*speed
		$PathFollow2D.progress = inc
		if ($PathFollow2D.progress_ratio - 0.99) >= 0:
			process_emit = false
			inc = 0
			spark.emitting = false
	pass
