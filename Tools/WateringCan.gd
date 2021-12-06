extends TextureButton
var watering = false

func _on_WateringCan_pressed():
	watering = !watering
	if watering:
		$Timer.start(0.1)
		$WaterParticles.emitting = true
	if !watering:
		$Timer.stop()
		$WaterParticles.emitting = false

