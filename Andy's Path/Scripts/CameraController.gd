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
var pk_timer
var pity_kill_timer: float
var pity_kill_timer_max: float = 3.0
var tween
var cameraTriggerRef


# NOTE: camera zoom HAS to evenly divide pixels or else it will double 
# and half pixels randomly at sprites !!!!!!!!!! looks BAD!!!!
# zoom like 0.25, 0.5, 1, etc. are good! just need to divide evenly


func _ready() -> void:
	beepboop = PackedVector2Array([Vector2(76956.07, -19679.35), Vector2(78563.4, -19679.35), Vector2(80170.27, -19679.35), Vector2(81783.92, -19679.35), Vector2(83387.06, -19679.35), Vector2(85000.36, -19679.35), Vector2(86614.01, -18080.52), Vector2(88207.38, -18848.34), Vector2(89798.91, -19574.58), Vector2(91380.52, -20553.68), Vector2(92971.99, -21034.33), Vector2(94573.52, -21034.33), Vector2(96177.52, -21664.99), Vector2(97781.12, -21664.99), Vector2(99385.29, -21664.99), Vector2(99676.94, -22379.78), Vector2(99456.56, -22932.28), Vector2(99592.21, -23373.66), Vector2(99586.24, -23950.36), Vector2(99840.0, -24982.53), Vector2(99006.67, -25918.37), Vector2(99963.74, -26479.88), Vector2(99040.93, -27038.75), Vector2(100168.8, -27670.46), Vector2(99056.28, -28043.08), Vector2(99707.05, -29074.55), Vector2(99420.88, -29531.33), Vector2(97902.0, -29988.82), Vector2(96123.39, -30951.43), Vector2(94344.14, -31790.04), Vector2(93196.77, -31790.04), Vector2(94118.09, -33824.0), Vector2(95373.58, -35882.93), Vector2(96636.65, -37949.64), Vector2(97896.33, -39996.07)])
	testbetterrecording = PackedVector2Array([Vector2(-1833.913, -201.0104),Vector2(-1445.782, -201.0104),Vector2(-1041.26, -201.0104),Vector2(-631.0073, -201.0104),Vector2(-218.7509, -201.0104),Vector2(194.2058, -201.0104),Vector2(607.4072, -201.0104),Vector2(1020.695, -201.0104),Vector2(1434.013, -201.0104),Vector2(1847.341, -201.0104),Vector2(2260.672, -201.0104),Vector2(2675.945, -201.0104),Vector2(3092.897, -201.0104),Vector2(3511.759, -201.0104),Vector2(3933.482, -201.0104),Vector2(4349.752, -201.0104),Vector2(4764.116, -201.0104),Vector2(5177.813, -201.0104),Vector2(5591.276, -201.0104),Vector2(6004.658, -201.0104),Vector2(6418.012, -201.0104),Vector2(6831.355, -201.0104),Vector2(7244.693, -201.0104),Vector2(7658.032, -201.0104),Vector2(8071.365, -201.0104),Vector2(8484.688, -201.0104),Vector2(8898.012, -201.0104),Vector2(9311.335, -201.0104),Vector2(9724.658, -201.0104),Vector2(10139.23, -201.0104),Vector2(10578.38, -201.0104),Vector2(11006.87, -201.0104),Vector2(11446.9, -201.0104),Vector2(11880.13, -201.0104),Vector2(12323.02, -201.0104),Vector2(12761.26, -201.0104),Vector2(13196.51, -201.0104),Vector2(13501.21, -201.0104),Vector2(13607.74, -541.2228),Vector2(13644.98, -867.871),Vector2(13658.0, -1111.0),Vector2(13662.55, -1353.835),Vector2(13664.14, -1596.67),Vector2(13664.7, -1839.225),Vector2(13520.23, -1861.078),Vector2(13201.05, -1861.078),Vector2(12820.64, -1861.078),Vector2(12418.82, -1861.078),Vector2(12024.05, -1861.078),Vector2(11807.45, -1861.078),Vector2(11189.47, -1861.078),Vector2(10540.73, -1861.078),Vector2(9994.695, -1861.078),Vector2(9484.569, -1861.078),Vector2(8986.999, -1861.078),Vector2(8493.815, -1861.078),Vector2(8002.163, -1861.078),Vector2(7616.944, -1861.078),Vector2(7023.853, -1861.078),Vector2(6514.072, -1861.078),Vector2(6033.416, -1861.078),Vector2(5562.942, -1861.078),Vector2(5096.029, -1861.078),Vector2(4631.319, -1861.078),Vector2(4361.849, -1861.078),Vector2(4299.731, -2481.857),Vector2(4180.131, -2979.939),Vector2(4136.31, -3527.625),Vector2(4140.184, -4102.125),Vector2(4165.1, -4545.224),Vector2(4197.669, -4792.785),Vector2(4240.861, -5335.553),Vector2(4298.58, -5570.211),Vector2(4478.982, -5206.101),Vector2(4568.949, -4240.689),Vector2(4600.401, -3293.477),Vector2(4620.229, -2488.032),Vector2(4832.21, -2460.313),Vector2(5175.165, -2460.313),Vector2(5563.905, -2460.313),Vector2(5968.645, -2460.313),Vector2(6378.979, -2460.313),Vector2(6786.909, -2460.313),Vector2(7198.175, -2460.313),Vector2(7610.79, -2460.313),Vector2(8023.87, -2460.313),Vector2(8437.109, -2460.313),Vector2(8817.518, -2460.313),Vector2(8934.706, -2904.01),Vector2(8918.927, -3342.579),Vector2(8888.069, -3694.474),Vector2(8840.979, -4139.706),Vector2(8562.969, -4197.837),Vector2(8196.951, -4197.837),Vector2(7800.156, -4197.837),Vector2(7392.601, -4197.837),Vector2(6981.282, -4197.837),Vector2(6566.116, -4197.837),Vector2(6127.773, -4197.837),Vector2(5749.368, -4197.837),Vector2(5516.871, -4803.853),Vector2(5434.894, -5289.983),Vector2(5620.205, -5521.741),Vector2(5953.822, -5521.741),Vector2(6339.29, -5521.741),Vector2(6742.884, -5521.741),Vector2(7137.334, -5521.741),Vector2(7150.674, -5982.526),Vector2(6886.507, -5982.526),Vector2(6525.318, -5982.526),Vector2(6130.209, -5982.526),Vector2(5879.72, -6540.215),Vector2(6039.561, -6580.957),Vector2(6364.274, -6580.957),Vector2(6746.63, -6580.957),Vector2(7126.813, -6913.06),Vector2(7126.312, -7285.131),Vector2(6857.303, -7285.131),Vector2(6494.422, -7285.131),Vector2(6099.292, -7285.131),Vector2(5910.444, -7919.624),Vector2(6103.416, -7938.712),Vector2(6439.711, -7938.712),Vector2(6826.117, -7938.712),Vector2(7221.843, -7938.712),Vector2(7349.787, -8463.992),Vector2(7425.67, -9032.218),Vector2(7356.505, -9564.832),Vector2(7068.394, -9578.299),Vector2(6698.834, -9578.299),Vector2(6300.799, -9578.299),Vector2(5906.233, -9578.299),Vector2(5749.353, -10233.24),Vector2(5682.632, -10790.53),Vector2(5820.576, -11078.3),Vector2(6137.634, -11078.3),Vector2(6517.313, -11078.3),Vector2(6918.885, -11078.3),Vector2(7202.088, -11078.3),Vector2(7060.931, -11417.93),Vector2(6742.75, -11417.93),Vector2(6362.677, -11417.93),Vector2(5982.3, -11670.45),Vector2(5974.958, -12121.27),Vector2(6241.225, -12121.27),Vector2(6603.145, -12121.27),Vector2(6998.396, -12121.27),Vector2(7316.129, -12752.71),Vector2(7449.65, -13289.87),Vector2(7419.559, -13840.66),Vector2(7152.634, -13904.15),Vector2(6790.481, -13904.15),Vector2(6395.037, -13904.15),Vector2(6024.895, -13904.15),Vector2(6036.169, -14290.7),Vector2(6307.895, -14290.7),Vector2(6671.724, -14290.7),Vector2(7055.521, -14290.7),Vector2(7119.749, -15004.37),Vector2(6873.944, -15004.37),Vector2(6519.176, -15004.37),Vector2(6126.312, -15004.37),Vector2(5939.16, -15581.78),Vector2(6130.551, -15625.86),Vector2(6466.294, -15625.86),Vector2(6852.507, -15625.86),Vector2(7207.028, -15981.34),Vector2(7148.456, -16224.65),Vector2(6859.146, -16224.65),Vector2(6489.169, -16224.65),Vector2(6093.262, -16224.65),Vector2(5957.289, -16877.71),Vector2(6173.141, -16894.29),Vector2(6517.437, -16894.29),Vector2(6906.637, -16894.29),Vector2(7311.536, -16894.29),Vector2(7721.925, -16894.29),Vector2(8134.223, -16894.29),Vector2(8487.777, -16894.29),Vector2(8673.286, -16894.29),Vector2(8826.591, -17272.69),Vector2(8880.188, -17815.73),Vector2(8898.928, -18281.0),Vector2(8905.479, -18652.82),Vector2(8907.769, -18117.6),Vector2(8908.568, -17126.34),Vector2(8908.849, -16796.76), Vector2(8908.947, -16796.76)])

	has_control = true
	screenIsMoving = false
	BREAK_THE_CYCLE = false
	in_path = false
	pity_kill_timer = pity_kill_timer_max
	
	cameraTriggerRef = $"../Camera_Change_Trigger"
	playerReference = $"../Player"
	print(playerReference)
	pk_timer = $"../CanvasLayer/Pity Kill Timer"

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
	"""recording_timer -= delta
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
		print(tempstring)"""
	
	if tween && not playerReference.find_child("VOSN2D").is_on_screen():
		pity_kill_timer -= delta
		if pity_kill_timer < 2.0:
			pk_timer.text = str(snapped(pity_kill_timer, 0.1))
		if pity_kill_timer <= 0:
			BREAK_THE_CYCLE = true
			if tween != null	:
				tween.kill()
			playerReference.die()
			tween.kill()
			pity_kill_timer = pity_kill_timer_max
			pk_timer.text = ""
	elif pk_timer != null:
		pk_timer.text = ""
		pity_kill_timer = pity_kill_timer_max

	if has_control and (cameraTriggerRef == null or !cameraTriggerRef.inCameraTrigger):
		if (abs(global_position.x - playerReference.position.x) + abs(global_position.y - playerReference.position.y)) > 10000:
			await wait(0.01)
			if has_control:
				print("TELEPORTED")
				global_position = playerReference.position + Vector2(0, -500)
		
		# Horizontal Movement
		self.global_position.x = lerp(self.global_position.x, playerReference.global_position.x, delta * 2)

		if screenIsMoving == false:
			if abs(self.global_position.y - playerReference.global_position.y) > offset1:
				screenIsMoving = true
		else:
			# Vertical Movement
			self.global_position.y = lerp(self.global_position.y, playerReference.global_position.y, delta * 10)
			
			# Stop moving when close enough
			if abs(self.global_position.y - playerReference.global_position.y) < 5:
				screenIsMoving = false
func ResetCamera():
	self.global_position.y = playerReference.global_position.y

func wait(duration):
	await get_tree().create_timer(duration).timeout
