extends Node2D
export var size = Vector2()
# 2 dimensional array y and x
var pixels_x = []
var active = []
var rng

func _ready():
	randomize()
	rng = RandomNumberGenerator.new()
	size.x = ProjectSettings.get_setting("display/window/size/width") / 2
	size.y = ProjectSettings.get_setting("display/window/size/height")
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
	var plant_seed = pixels_x[size.x / 2][size.y - 8]
	plant_seed.active = true
	active.append(plant_seed)
	
func grow():
	if (randi() % 2) == 1:
		new_pixel(active[active.size() - 1])
	else:
		new_pixel(active[randi() % active.size()])

func new_pixel(original_pixel):
	var var_x = rng.randi_range(-1, 1)
	var var_y = rng.randi_range(-1, 0)
	var new_position = Vector2(original_pixel.position)
	new_position.x = clamp(new_position.x + var_x, 0, pixels_x.size() - 1)
	new_position.y = clamp(new_position.y + var_y, 0, pixels_x[new_position.x].size() - 1)
	var new_pixel = pixels_x[new_position.x][new_position.y]
	if !new_pixel.active:
		active.append(new_pixel)
	new_pixel.age_up()
	
