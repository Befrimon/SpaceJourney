extends CharacterBody2D
class_name Enemy

signal hit

@export var speed = 1e3

var health: int = 3
var player: Tile

func _physics_process(delta: float) -> void:
	if player:
		velocity = Vector2(0, 1).direction_to(Global.player_position - global_position) * speed * delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_hit() -> void:
	health -= 1
	if health <= 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Tile and !player:
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
