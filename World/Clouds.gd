extends Node2D

var size = Vector2(ProjectSettings.get_setting("display/window/size/width") / 2, 
		ProjectSettings.get_setting("display/window/size/height") - 80)

func _ready():
	$Timer.wait_time = rand_range(15, 120)
	$Timer.start()


func _on_Timer_timeout():
	var Cloud = preload("res://World/Cloud.tscn")
	var cloud = Cloud.instance()
	add_child(cloud)
	var pos
	if randi() % 2 == 0:
		pos = Vector2(0, randi() % int(size.y))
		cloud.direction = 0.1
	else:
		pos = Vector2(size.x, randi() % int(size.y))
		cloud.direction = -0.1
	cloud.global_position = pos
	$Timer.wait_time = rand_range(15,120)
	
	
