extends Sprite



func _on_Plant_good_water() -> void:
	var main = get_tree().current_scene
	var Particle = preload("res://World/GoodAndWellBalancedWaterParticles.tscn")
	var particle = Particle.instance()
	particle.one_shot = true
	particle.emitting = true
	main.add_child(particle)
	particle.global_position = global_position
	particle.global_position.y -= 2
