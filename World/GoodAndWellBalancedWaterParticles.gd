extends Particles2D

func _on_Delete_timeout() -> void:
	queue_free()
