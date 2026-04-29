extends RayCast2D

@export var sprite: Sprite2D = null
@export var boss_sprite: Sprite2D = null

var target: Enemy = null
var boss_target: Boss = null

func _ready() -> void:
	if boss_target:
		sprite.hide()
		boss_sprite.show()

func _process(_delta: float) -> void:
	if !is_instance_valid(target) and !is_instance_valid(boss_target):
		queue_free()
		return
	
	if target:
		look_at(target.global_position)
		visible = !target.on_screen
	elif boss_target:
		look_at(boss_target.global_position)
		visible = !boss_target.on_screen
