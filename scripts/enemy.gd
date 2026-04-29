extends CharacterBody2D
class_name Enemy

signal hit

@export var speed = 1e3

var health: int = 3

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 1).direction_to(Global.player_position - global_position) * speed * delta
	move_and_slide()

func _on_hit() -> void:
	health -= 1
	if health <= 0:
		queue_free()
