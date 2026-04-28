extends Node2D

@export var is_player: bool = false
@export var data: CannonData = Constants.CANNONS.default
@export var timer: Timer = null

var bullet: PackedScene = preload("uid://6iumdjknhmpy")

func _ready() -> void:
	timer.wait_time = data.delay

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _shoot() -> void:
	var instance: Bullet = bullet.instantiate()
	instance.direction = rotation
	instance.speed = data.speed
	instance.life_time = data.life_time
	instance.position = global_position
	
	if is_player:
		instance.parent = Bullet.Owners.PLAYER
	else:
		instance.parent = Bullet.Owners.ENEMY
	
	add_child(instance)
