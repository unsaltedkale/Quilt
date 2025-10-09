extends RigidBody2D

@export var damage_amount: int = 5

func _ready():
	var damage_area = $DamageArea
	if damage_area:
		damage_area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage_amount)
