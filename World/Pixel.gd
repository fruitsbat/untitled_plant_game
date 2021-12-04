extends ColorRect
var active = false
var position = Vector2()
var age = 0

export var colors = [
		Color("#00ffffff"),
		Color("#91e369"), 
		Color("#56c157"), 
		Color("#46a65c"), 
		Color("#358859")]

func age_up():
	if !(age >= 4):
		age += 1
		color = colors[age]
		active = true

func _ready() -> void:
	color = colors[age]
