extends Node2D
export var size = Vector2(128, 144)
# 2 dimensional array y and x
var pixels_y = []

func _ready():
	call_deferred("spawn_pixels")

func spawn_pixels():
	for n in size.x:
		var pixels_x = []
		for i in size.y:
			var Main = get_tree().current_scene
			var Pixel = preload("res://World/Pixel.tscn")
			var pixel = Pixel.instance()
			# set position
			pixel.rect_global_position = Vector2(n, i)
			# show in scene
			Main.add_child(pixel)
			# initilize array
			pixels_y.append(pixel)
		pixels_x.append(pixels_y)

