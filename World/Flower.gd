extends AnimatedSprite

var can_be_removed = false


func _ready() -> void:
	frame = 0
	play("blossom")
	$Tween.interpolate_property(self, "rotation_degrees", 0, 360, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()

func remove():
	can_be_removed = true
	play("remove")

func _on_Flower_animation_finished() -> void:
	if can_be_removed:
		queue_free()
