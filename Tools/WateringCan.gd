extends TextureButton
var watering = false

func _on_WateringCan_pressed():
	watering = !watering
	if watering:
		$Timer.start(1)
		$Particles2D.emitting = true
	if !watering:
		$Timer.stop()
		$Particles2D.emitting = false

