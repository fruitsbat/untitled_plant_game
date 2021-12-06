extends Sprite

var direction = 0

func _physics_process(delta):
	global_position += Vector2(direction, 0)


func _on_Timer_timeout():
	queue_free()
