extends Node2D
class_name Cannon

@export var is_player: bool = false
@export var data: CannonData = Constants.CANNONS.default
@export var timer: Timer = null

var bullet: PackedScene = preload("uid://6iumdjknhmpy")
var enabled: bool = true

func _ready() -> void:
	timer.wait_time = data.delay

func _process(_delta: float) -> void:
	if is_player:
		look_at(get_global_mouse_position())
	else:
		look_at(Global.player_position)

func set_data(new_data: CannonData) -> void:
	data = new_data
	timer.wait_time = data.delay

func pause_shoot() -> void:
	enabled = false
func resume_shoot() -> void:
	enabled = true

func _shoot() -> void:
	var instance: Bullet = bullet.instantiate()
	instance.direction = rotation
	instance.speed = data.speed
	instance.life_time = data.life_time
	instance.damage = data.damage
	instance.sprite.animation = data.animation
	instance.position = global_position
	
	if is_player:
		instance.parent = Bullet.Owners.PLAYER
	else:
		instance.parent = Bullet.Owners.ENEMY
	
	if enabled:
		add_child(instance)
