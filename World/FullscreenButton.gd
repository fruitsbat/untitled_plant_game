extends TextureButton



func _on_FullscreenButton_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
