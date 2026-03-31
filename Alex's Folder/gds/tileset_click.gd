extends TileMapLayer

@export var on_ready_click_on: bool = false
var click_on
var click_off

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_ready_click_on:
		#turn ON
		click_on = true
		click_off = false
	else:
		# turn OFF
		click_off = true
		click_on = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if click_on == true:
		print("CLICK ON " + self.name)
		visible = true
		collision_enabled = true
		click_on = false
	if click_off == true:
		print("CLICK OFF " + self.name)
		visible = false
		collision_enabled = false
		click_off = false
		
	pass
