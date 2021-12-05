extends RichTextLabel

func _ready() -> void:
	visible_characters = 0

func _on_Plant_has_need(need_and_value) -> void:
	print_message(need_and_value)

func print_message(mesage):
	$Reveal.start()
	text = text + "\n >" + str(mesage) + "\n "


func _on_Reveal_timeout() -> void:
	if visible_characters <= text.length():
		visible_characters += 1
	else: $Reveal.stop()
