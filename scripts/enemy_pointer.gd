extends RayCast2D

@export var sprite: Sprite2D = null

var target: Enemy = null

func _process(_delta: float) -> void:
	if !is_instance_valid(target):
		queue_free()
		return
	
	look_at(target.global_position)
	visible = !target.on_screen
