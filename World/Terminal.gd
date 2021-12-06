extends RichTextLabel

signal was_social()
var can_show_mesage = true
var last = "sample tess"

var water_msg_low = [
	"Please water me :o",
	"I'm THIRSTY i could drink a [shake rate=10 level=2]100!!![/shake] ... somethings"
	]
var water_msg_high = [
	"EEE! Too wet!!!",
	"The pot is like a swamp... :(",
	"I need to dry!!!",
	"Wet wet wet!!!! AAAAAA",
	"Way too wet :( If this was nintendo ds game i would ask you to blow into the microphone, but [shake rate=10 level=2]NO![/shake]"
	]
var water_msg_good = [
	"Comfy wet soil :)",
	"Thank you!!!",
	"Thank you for taking such good care of me!",
	"When i'm happy i grow [shake rate=10 level=2]flowers[/shake]!"
	]

var social = [
	"You ever think about bees?",
	"You like [wave amp=24 freq=2]Jazz[/wave]?",
	"Trans rights!",
	"[wave amp=24 freq=2]eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee[/wave]",
	"Fun fact! [wave amp=24 freq=2]uhhhhidk[/wave]",
	"Look up cool bug facts and tell me one! Quick!!!",
	"Ladybirds play dead to avoid predators. Don't we all sometimes...",
	"Do you ever forget if you already told someone something and then you just tell them like [shake rate=10 level=2]50 times[/shake]? Yeah.",
	"If i had to fight someone i would simply look up the weaknesses section on their wikipedia page.",
]

func _ready() -> void:
	visible_characters = 0

func _on_Plant_has_need(need_and_values) -> void:
	if need_and_values[0] == "water":
		tell_about_water(need_and_values)
	if need_and_values[0] == "social" && can_show_mesage:
		tell_about_social()

func tell_about_social():
	print_message(social[randi() % social.size()])
	emit_signal("was_social")

func tell_about_water(need_and_values):
	if need_and_values[2] > 60:
		if !(last == "high_water"): can_show_mesage = true
		print_message(water_msg_high[randi() % water_msg_high.size()])
		last = "high_water"
	elif need_and_values[2] < 40:
		if !(last == "low_water"): can_show_mesage = true
		print_message(water_msg_low[randi() % water_msg_low.size()])
		last = "low_water"
	else:
		if !(last == "good_water"): can_show_mesage = true
		print_message(water_msg_good[randi() % water_msg_good.size()])
		last = "good_water"

func print_message(mesage):
	if can_show_mesage:
		$Reveal.start()
		bbcode_text = bbcode_text + "\n>" + str(mesage) + "\n"
		can_show_mesage = false
		$MessageTimer.start(5)


func _on_Reveal_timeout() -> void:
	if visible_characters <= text.length():
		visible_characters += 1
	else: $Reveal.stop()


func _on_MessageTimer_timeout() -> void:
	can_show_mesage = true
	if randi() % 3 == 0:
		tell_about_social()
