extends Node2D
export var size = Vector2()
# 2 dimensional array y and x
var pixels_x = []
var active = []
var rng
var branches = 4

var water = 20
var health = 100
var social = 50
var light = 50
var last_need = ["x", -100, -100]

var was_silent = false

signal good_water()
signal has_need(need_and_value)

func get_mood() -> int:
	return (
		abs(50 - water) * 2 +
		abs(50 - light) * 2 +
		(100 - social) + 
		(100 - health))

func _process(_delta):
	#step()
	pass


func step():
	$Timer.wait_time = abs(float(get_mood()) / 100) + 0.25
	call_deferred("grow")
	if (randi() % 150 == 0) && (get_mood() < 50):
		blossom()
	communicate_needs()

func communicate_needs():
	var needs = [abs((50 - water) * 2), 100 - health, 100 - social, abs((50 - light) * 2)]
	var needs_for_real = [water, health, social, light]
	var most_important = ["cool name sample text", needs[0], needs_for_real[0]]
	var i = 0
	for need in needs:
		if most_important[1] <= need:
			most_important[1] = need
			most_important[2] = needs_for_real[i]
			most_important[0] = i
		i += 1
	var names = ["water", "health", "social", "light"]
	most_important[0] = names[most_important[0]]
	if (last_need[0] != most_important[0]) || (abs(last_need[1] - most_important[1]) >= 10) || was_silent:
		emit_signal("has_need", most_important)
		last_need = most_important
		was_silent = false
		$TalkTimer.start(15)


func _ready():
	randomize()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	size.x = ProjectSettings.get_setting("display/window/size/width") / 2
	size.y = ProjectSettings.get_setting("display/window/size/height")
	call_deferred("spawn_pixels")
	call_deferred("plant_seed")
	branches = rng.randi_range(2, 24)
	print(branches)


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
	var plant_seed = pixels_x[size.x / 2][size.y - 10]
	plant_seed.active = true
	active.append(plant_seed)


func grow():
	if (randi() % branches) >= 1:
		new_pixel(active[active.size() - 1])
	else:
		new_pixel(active[randi() % active.size()])


func new_pixel(original_pixel):
	var var_x = rng.randi_range(-1, 1)
	var var_y
	#grow down
	if (randi() % 2) == 0:
		var_y = rng.randi_range(-1, 1)
	# grow regularly
	else: var_y = rng.randi_range(-1, 0)
	var new_position = Vector2(original_pixel.position)
	new_position.x = clamp(new_position.x + var_x, 0, pixels_x.size() - 1)
	new_position.y = clamp(new_position.y + var_y, 0, pixels_x[new_position.x].size() - 1)
	var new_pixel = pixels_x[new_position.x][new_position.y]
	if !new_pixel.active:
		active.append(new_pixel)
	new_pixel.age_up()


func blossom():
	var Flower = preload("res://World/Flower.tscn")
	var flower = Flower.instance()
	var main = get_tree().current_scene
	flower.global_position = active[randi() % active.size()].position
	main.add_child(flower)


func _on_WaterTimer_timeout() -> void:
	water = clamp(water - 1, 0, 100)
	social = clamp(social - 2, 0, 100)


func add_water():
	water = clamp(water + 1, 0, 100)
	if water == 55:
		$WaterSFX.play(0)
		emit_signal("good_water")


func _on_TalkTimer_timeout() -> void:
	was_silent = true


func _on_Terminal_was_social() -> void:
	social += clamp(social + randi() % 11, 0, 10)
