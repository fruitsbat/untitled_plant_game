extends Node2D
export var size = Vector2(128, 144)
# 2 dimensional array y and x
var pixels_x = []

func _ready():
	call_deferred("spawn_pixels")
	call_deferred("plant_seed")

func spawn_pixels():
	for n in size.x:
		var pixels_y = []
		for i in size.y:
			var Main = get_tree().current_scene
			var Pixel = preload("res://World/Pixel.tscn")
			var pixel = Pixel.instance()
			# set position
			pixel.rect_global_position = Vector2(n, i)
			pixel.position = Vector2(n, i)
			# show in scene
			Main.add_child(pixel)
			# initilize array
			pixels_y.append(pixel)
		pixels_x.append(pixels_y)

func plant_seed():
	var rect = pixels_x[size.x / 2][size.y - 8]
	rect.color = rect.light_green

func grow():
	pass
