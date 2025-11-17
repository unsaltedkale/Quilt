extends Area2D

var isInTrigger

func _ready():
	# Connect the signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		isInTrigger = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		isInTrigger = false
