extends CharacterBody2D
class_name Enemy

signal hit

var health: int = 3

func _on_hit() -> void:
	health -= 1
	if health <= 0:
		queue_free()
