extends Sprite2D


func _process(delta: float) -> void:
	look_at(get_local_mouse_position())
