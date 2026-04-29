extends CharacterBody2D
class_name Bullet

enum Owners {
	UNKNOWN,
	PLAYER,
	ENEMY,
}

@export var timer: Timer = null
@export var sprite: Sprite2D = null

var speed: float = 1e4
var life_time: float = 1.0
var direction: float = 0.0

var parent := Owners.UNKNOWN

func _ready() -> void:
	timer.start(life_time)
	rotate(direction)
	
	match (parent):
		Owners.PLAYER:
			collision_mask = 2
		Owners.ENEMY:
			collision_mask = 1
			sprite.modulate = Color(0.0, 1.0, 1.0, 1.0)

func _physics_process(delta: float) -> void:
	velocity = Vector2(1, 0).rotated(direction) * speed * delta
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var body = get_slide_collision(i).get_collider()
		
		if parent == Owners.ENEMY and body is Tile:
			body.emit_signal("hit")
			queue_free()
		elif parent == Owners.PLAYER and body is Enemy:
			body.emit_signal("hit")
			queue_free()

func _death() -> void:
	queue_free()
