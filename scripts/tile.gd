extends StaticBody2D
class_name Tile

signal hit

@export var is_root: bool = false
@export var data: MyTileData = Constants.TILE_DATA.block

@export var sprite: Sprite2D = null  
@export var hitbox: CollisionShape2D = null
@export var allow_area: Area2D = null
@export var deny_area: Area2D = null

var placed: bool = false
var health: int = 3
var neighbours: Array[Tile] = []

func _ready() -> void:
	sprite.texture = data.texture
	
	if is_root:
		build()

func _process(_delta: float) -> void:
	if !placed and !check_prebuild():
		sprite.modulate = Color(1, 0, 0)
	elif !placed:
		sprite.modulate = Color(0, 1, 0)
		

func check_root() -> bool:
	if is_root:
		return true
	
	var res = false
	for n in neighbours:
		res = res or n.check_root()
	return res

func build() -> void:
	placed = true
	hitbox.disabled = false
	sprite.modulate = Color(1, 1, 1)

func check_prebuild() -> bool:
	return allow_area.get_overlapping_bodies().size() > 0 and deny_area.get_overlapping_bodies().size() == 0

func _on_hit() -> void:
	health -= 1
	if health <= 0:
		_death()

func _death() -> void:
	pass
