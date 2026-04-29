extends CharacterBody2D
class_name Enemy

signal hit(dmg: int)

@export var data: EnemyData = null
@export var sprite: AnimatedSprite2D = null
@export var cannon: Cannon = null
@export var notifier: VisibleOnScreenNotifier2D = null

var health: int = 0
var on_screen: bool = false

func _ready() -> void:
	health = data.max_health
	sprite.sprite_frames = data.animation
	sprite.play("default")
	cannon.set_data(data.weapon)

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 1).direction_to(Global.player_position - global_position) * data.speed * delta * Global.wave_speed
	move_and_slide()
	
	on_screen = notifier.is_on_screen()

func _on_hit(dmg: int) -> void:
	health -= dmg
	if health <= 0:
		queue_free()
