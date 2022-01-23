extends TextureButton
var watering = false

func _on_WateringCan_pressed():
	watering = !watering
	if watering:
		$Timer.start(0.1)
		$WaterParticles.emitting = true
	if !watering:
		stop_watering()

func on_enough_water():
	watering = false
	stop_watering()

func stop_watering():
	$Timer.stop()
	$WaterParticles.emitting = false
