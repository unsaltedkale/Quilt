extends Camera2D

var offset1 = 400 #screen bounds

var playerReference
var screenIsMoving
var has_control: bool
var recording_timer = 0
var recording_timer_max = 0.5
var list: Array[Vector2]
var BREAK_THE_CYCLE: bool
var beepboop
var testbetterrecording
var in_path: bool
var pity_kill_timer: float
var pity_kill_timer_max: float = 3.0
var tween


# NOTE: camera zoom HAS to evenly divide pixels or else it will double 
# and half pixels randomly at sprites !!!!!!!!!! looks BAD!!!!
# zoom like 0.25, 0.5, 1, etc. are good! just need to divide evenly


func _ready() -> void:
	beepboop = PackedVector2Array([Vector2(76956.07, -19679.35), Vector2(78563.4, -19679.35), Vector2(80170.27, -19679.35), Vector2(81783.92, -19679.35), Vector2(83387.06, -19679.35), Vector2(85000.36, -19679.35), Vector2(86614.01, -18080.52), Vector2(88207.38, -18848.34), Vector2(89798.91, -19574.58), Vector2(91380.52, -20553.68), Vector2(92971.99, -21034.33), Vector2(94573.52, -21034.33), Vector2(96177.52, -21664.99), Vector2(97781.12, -21664.99), Vector2(99385.29, -21664.99), Vector2(99676.94, -22379.78), Vector2(99456.56, -22932.28), Vector2(99592.21, -23373.66), Vector2(99586.24, -23950.36), Vector2(99840.0, -24982.53), Vector2(99006.67, -25918.37), Vector2(99963.74, -26479.88), Vector2(99040.93, -27038.75), Vector2(100168.8, -27670.46), Vector2(99056.28, -28043.08), Vector2(99707.05, -29074.55), Vector2(99420.88, -29531.33), Vector2(97902.0, -29988.82), Vector2(96123.39, -30951.43), Vector2(94344.14, -31790.04), Vector2(93196.77, -31790.04), Vector2(94118.09, -33824.0), Vector2(95373.58, -35882.93), Vector2(96636.65, -37949.64), Vector2(97896.33, -39996.07)])
	testbetterrecording = PackedVector2Array([Vector2(75355.14, -19670.3), Vector2(75765.16, -19670.3), Vector2(76164.16, -19670.3), Vector2(76577.1, -19670.3), Vector2(76990.37, -19670.3), Vector2(77403.78, -19670.3), Vector2(77812.31, -19670.3), Vector2(78221.66, -19670.3), Vector2(78628.24, -19670.3), Vector2(79037.26, -19670.3), Vector2(79449.15, -19670.3), Vector2(79862.03, -19670.3), Vector2(80275.26, -19670.3), Vector2(80688.67, -19670.3), Vector2(81102.09, -19670.3), Vector2(81515.5, -19670.3), Vector2(81928.91, -19670.3), Vector2(82330.05, -19670.3), Vector2(82734.57, -19670.3), Vector2(83144.88, -19670.3), Vector2(83557.21, -19670.3), Vector2(83970.27, -19670.3), Vector2(84383.57, -19670.3), Vector2(84796.98, -19670.3), Vector2(85210.4, -19670.3), Vector2(85623.81, -19670.3), Vector2(86037.23, -19116.96), Vector2(86450.64, -18133.23), Vector2(86862.77, -18079.6), Vector2(87269.01, -18350.18), Vector2(87671.37, -18819.4), Vector2(88080.05, -18864.4), Vector2(88489.12, -18864.4), Vector2(88893.81, -18864.4), Vector2(89297.35, -19586.88), Vector2(89707.33, -19587.87), Vector2(90116.26, -19587.87), Vector2(90522.77, -19587.87), Vector2(90925.74, -20326.11), Vector2(91335.5, -20335.17), Vector2(91742.38, -20335.17), Vector2(92147.52, -20573.83), Vector2(92552.7, -21038.91), Vector2(92963.23, -21038.91), Vector2(93369.95, -21038.91), Vector2(93778.61, -21038.91), Vector2(94190.36, -21038.91), Vector2(94603.19, -21038.91), Vector2(95009.99, -21547.03), Vector2(95419.34, -21673.15), Vector2(95831.34, -21673.15), Vector2(96244.27, -21673.15), Vector2(96651.64, -21673.15), Vector2(97061.54, -21673.15), Vector2(97473.73, -21673.15), Vector2(97886.72, -21673.15), Vector2(98294.22, -21673.15), Vector2(98703.71, -21673.15), Vector2(99115.76, -21673.15), Vector2(99528.7, -21673.15), Vector2(99936.47, -21673.15), Vector2(100066.2, -22411.49), Vector2(99843.52, -22419.2), Vector2(99496.79, -22419.2), Vector2(99119.23, -22419.2), Vector2(99068.22, -22930.52), Vector2(99319.27, -22933.32), Vector2(99675.91, -22933.32), Vector2(100029.2, -22933.32), Vector2(99982.48, -23445.61), Vector2(99697.26, -23445.61), Vector2(99333.03, -23445.61), Vector2(99038.03, -23677.75), Vector2(99161.2, -23943.34), Vector2(99473.13, -23943.34), Vector2(99847.03, -23943.34), Vector2(100134.9, -24407.11), Vector2(100146.1, -24935.12), Vector2(99887.81, -24946.05), Vector2(99528.62, -24946.05), Vector2(99139.66, -24946.05), Vector2(98912.59, -25640.54), Vector2(98943.34, -25971.81), Vector2(99222.01, -25971.81), Vector2(99588.3, -25971.81), Vector2(99974.44, -25971.81), Vector2(100002.3, -26499.73), Vector2(99743.12, -26501.7), Vector2(99384.01, -26501.7), Vector2(99036.32, -26501.7), Vector2(99093.33, -27033.85), Vector2(99382.15, -27033.85), Vector2(99748.98, -27033.85), Vector2(100048.6, -27033.85), Vector2(100173.4, -27851.32), Vector2(100025.4, -28041.45), Vector2(99704.83, -28041.45), Vector2(99325.91, -28041.45), Vector2(99012.54, -28224.69), Vector2(98914.59, -28974.35), Vector2(99119.57, -29071.71), Vector2(99460.11, -29071.71), Vector2(99845.96, -29071.71), Vector2(100018.5, -29441.72), Vector2(99814.45, -29535.44), Vector2(99474.26, -29535.44), Vector2(99088.66, -29535.44), Vector2(98689.71, -29535.44), Vector2(98251.84, -29535.44), Vector2(97801.38, -30058.81), Vector2(97346.48, -30307.34), Vector2(96889.97, -30547.98), Vector2(96433.05, -30788.48), Vector2(95975.89, -31029.04), Vector2(95518.64, -31269.59), Vector2(95061.39, -31510.14), Vector2(94604.14, -31750.69), Vector2(94162.3, -31790.04), Vector2(93738.95, -31790.04), Vector2(93356.32, -31790.04), Vector2(93188.35, -31790.04), Vector2(93129.88, -31790.04), Vector2(93256.66, -32173.72), Vector2(93511.43, -32777.3), Vector2(93810.94, -33306.49), Vector2(94126.05, -33835.43), Vector2(94446.57, -34364.37), Vector2(94768.99, -34893.3), Vector2(95092.07, -35422.24), Vector2(95415.39, -35951.18), Vector2(95738.74, -36480.12), Vector2(96062.17, -37009.05), Vector2(96385.61, -37537.99), Vector2(96709.05, -38066.93), Vector2(97032.48, -38595.87), Vector2(97355.92, -39124.8), Vector2(97668.92, -39636.68), Vector2(97968.41, -40019.58), Vector2(98101.48, -40019.58), Vector2(98331.98, -40019.58), Vector2(98503.52, -40019.58), ])

	has_control = true
	screenIsMoving = false
	BREAK_THE_CYCLE = false
	in_path = false
	pity_kill_timer = pity_kill_timer_max
	
	playerReference = $"../Player"

func _path(string: String):
	var vinyl: PackedVector2Array
	if string == "crypt":
		vinyl = testbetterrecording
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
		await wait(1)
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
				tween.tween_property(self, "position", vinyl[i], 0.5)
				await tween.finished
		print("TWEEN DONE")

func player_died():
	if tween:
		tween.kill()
	has_control = true
	BREAK_THE_CYCLE = true
	pass

func _process(delta: float) -> void:
	#ddprint(str(has_control) + " / " + str(BREAK_THE_CYCLE) + " / " + str(get_tree().get_processed_tweens()))
	
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
		var tempstring: String
		tempstring = ""
		tempstring += "PackedVector2Array(["
		for a in list:
			tempstring += "Vector2" + str(a) + ", "
		tempstring += "])"
		print(tempstring)'''
	
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
	elif $"../CanvasLayer/Pity Kill Timer" != null:
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
