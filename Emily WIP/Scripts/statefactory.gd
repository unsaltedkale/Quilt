extends Node
class_name Sate_Factory

var states

func _init():
	states ={
		"idle": Idle,
		"walk": Walk,
		"jump": Jump
		#"fall": Fall,
		#"walljump": WallJump,
		#"wallslide": WallSlide,
		#"recoil": Recoil,
		#"crouch": Crouch,
		#"cutscene": Cutscene,
		#"stasis": Stasis,
		#"death": Death
	}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		print("No state ", state_name, " in state factory!")
