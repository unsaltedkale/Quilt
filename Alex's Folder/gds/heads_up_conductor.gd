extends Node2D

@onready var c = $"../../Conductor"
@onready var t = $RichTextLabel2
@onready var tween

func _execute(mr: music_resource):
	print("heads_up")
	var on_screen_pos = Vector2(1690, 960)
	var off_screen_pos = Vector2(2230, 960)
	
	c = $"../../Conductor"
	
	t = $RichTextLabel2
	
	if mr.display_name != "" && mr.display_name != null:
		
		print("<" + mr.display_name + ">")
		
		t.text = mr.display_name
		
		tween = get_tree().create_tween()
	
		if c.heads_up_display_moving == true:
			tween.stop()
			tween.kill()
		
		position = off_screen_pos
		
		c.heads_up_display_moving = true	
		
		print("one")
		
		tween.tween_property(self, "position", on_screen_pos, 1.0)
		
		await tween.finished
		
		print("one finished")
		
		await wait(4)
		
		print("two")
		
		tween = get_tree().create_tween()
		
		tween.tween_property(self, "position", off_screen_pos, 1.0)
		
		await tween.finished
		
		print("two finished")
		
		c.heads_up_display_moving = false
	
	pass

func wait(duration):
	await get_tree().create_timer(duration).timeout
