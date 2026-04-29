extends CharacterBody2D
class_name Bullet

enum Owners {
	UNKNOWN,
	PLAYER,
	ENEMY,
}

@export var timer: Timer = null
@export var sprite: AnimatedSprite2D = null

var speed: float = 1e4
var life_time: float = 1.0
var direction: float = 0.0
var damage: int = 0

var parent := Owners.UNKNOWN

func _ready() -> void:
	timer.start(life_time)
	rotate(direction)
	
	match (parent):
		Owners.PLAYER:
			collision_mask = 2
			sprite.sprite_frames = Constants.BULLETS.player_default
		Owners.ENEMY:
			collision_mask = 1
			sprite.sprite_frames = Constants.BULLETS.enemy_default
	sprite.play()

func _physics_process(delta: float) -> void:
	velocity = Vector2(1, 0).rotated(direction) * speed * delta * Global.wave_speed
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var body = get_slide_collision(i).get_collider()
		
		if parent == Owners.ENEMY and body is Tile:
			body.hit.emit(damage)
			queue_free()
		elif parent == Owners.PLAYER and body is Enemy:
			body.hit.emit(damage)
			queue_free()

func _death() -> void:
	queue_free()
