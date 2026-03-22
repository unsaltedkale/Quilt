extends Camera2D

var offset1 = 400 #screen bounds

var playerReference
var screenIsMoving
var has_control: bool
var recording_timer = 0
var recording_timer_max = 3
var list: Array[Vector2]
var TEST_LIST_FOR_CRYPT: Array[Vector2]
var BREAK_THE_CYCLE: bool
var beepboop
var in_path: bool
var pity_kill_timer: float
var pity_kill_timer_max: float = 4.0
var tween


# NOTE: camera zoom HAS to evenly divide pixels or else it will double 
# and half pixels randomly at sprites !!!!!!!!!! looks BAD!!!!
# zoom like 0.25, 0.5, 1, etc. are good! just need to divide evenly


func _ready() -> void:
	beepboop = PackedVector2Array([Vector2(76956.07, -19679.35), Vector2(78563.4, -19679.35), Vector2(80170.27, -19679.35), Vector2(81783.92, -19679.35), Vector2(83387.06, -19679.35), Vector2(85000.36, -19679.35), Vector2(86614.01, -18080.52), Vector2(88207.38, -18848.34), Vector2(89798.91, -19574.58), Vector2(91380.52, -20553.68), Vector2(92971.99, -21034.33), Vector2(94573.52, -21034.33), Vector2(96177.52, -21664.99), Vector2(97781.12, -21664.99), Vector2(99385.29, -21664.99), Vector2(99676.94, -22379.78), Vector2(99456.56, -22932.28), Vector2(99592.21, -23373.66), Vector2(99586.24, -23950.36), Vector2(99840.0, -24982.53), Vector2(99006.67, -25918.37), Vector2(99963.74, -26479.88), Vector2(99040.93, -27038.75), Vector2(100168.8, -27670.46), Vector2(99056.28, -28043.08), Vector2(99707.05, -29074.55), Vector2(99420.88, -29531.33), Vector2(97902.0, -29988.82), Vector2(96123.39, -30951.43), Vector2(94344.14, -31790.04), Vector2(93196.77, -31790.04), Vector2(94118.09, -33824.0), Vector2(95373.58, -35882.93), Vector2(96636.65, -37949.64), Vector2(97896.33, -39996.07)])
	TEST_LIST_FOR_CRYPT.append_array(beepboop)
	has_control = true
	screenIsMoving = false
	BREAK_THE_CYCLE = false
	in_path = false
	pity_kill_timer = pity_kill_timer_max
	
	playerReference = $"../Player"

func _path(string: String):
	var vinyl: PackedVector2Array
	if string == "crypt":
		vinyl = beepboop
	elif string == "jailbreak":
		print("ERROR: VINYL STRING <jailbreak> HAS NOT BEEN WRITTEN TO YET.")
	elif string == "flow appears":
		print("ERROR: VINYL STRING <flow appears> HAS NOT BEEN WRITTEN TO YET.")
	else:
		print("ERROR: VINYL STRING NOT VALID.")
	BREAK_THE_CYCLE = false
	if vinyl != null:
		if tween:
			tween.kill()
		await wait(1.5)
		for i in vinyl.size():
			print("click")
			if BREAK_THE_CYCLE == true:
				print_debug("TWEEN CAMERA CYCLE BROKEN")
				if tween:
					tween.kill()
				break
				BREAK_THE_CYCLE = false
				has_control = true
			else:
				if tween	:
					tween.kill()
				tween = get_tree().create_tween()
				tween.tween_property(self, "position", vinyl[i], 2)
				await tween.finished
		print("TWEEN DONE")

func player_died():
	tween.kill()
	has_control = true
	BREAK_THE_CYCLE = true
	pass

func _process(delta: float) -> void:
	print(str(has_control) + " / " + str(BREAK_THE_CYCLE) + " / " + str(get_tree().get_processed_tweens()))
	
	if tween:
		has_control = !tween.is_running()
	
	#pls no delete I actually Need this -- Alex
	'''recording_timer -= delta
	if recording_timer <= 0:
		var tempvar = position
		list.append(tempvar)
		print(tempvar)
		recording_timer = recording_timer_max
	if Input.is_action_just_pressed("crouch"):
		print(list)'''
	
	if tween && not playerReference.find_child("VOSN2D").is_on_screen():
		pity_kill_timer -= delta
		if pity_kill_timer < 2.0:
			$"../CanvasLayer/Pity Kill Timer".text = str(snapped(pity_kill_timer, 0.1))
		if pity_kill_timer <= 0:
			BREAK_THE_CYCLE = true
			if tween != null	:
				tween.kill()
			playerReference.die()
			tween.kill()
			pity_kill_timer = pity_kill_timer_max
			$"../CanvasLayer/Pity Kill Timer".text = ""
	else:
		$"../CanvasLayer/Pity Kill Timer".text = ""
		pity_kill_timer = pity_kill_timer_max

	if has_control:	
		
		if (abs(global_position.x - playerReference.position.x) + abs(global_position.y - playerReference.position.y)) > 1000:
			await wait(0.1)
			if has_control:
				print("TELEPORTED")
				global_position = playerReference.position + Vector2(0, -500)
		
		#Horizontal Movement
		self.global_position.x = lerp(self.global_position.x, playerReference.global_position.x, delta * 2)

		if screenIsMoving == false:
			if abs(self.global_position.y - playerReference.global_position.y) > offset1:
				screenIsMoving = true
		else:
			#Vertical Movement
			self.global_position.y = lerp(self.global_position.y, playerReference.global_position.y, delta * 10)
			
			#Move to target position if magnitude of distance < 10
			if abs((self.global_position.y - playerReference.global_position.y)) < 5:
				screenIsMoving = false

func wait(duration):
	await get_tree().create_timer(duration).timeout
