extends StaticBody2D
class_name Tile

signal hit(dmg: int)

@export var is_root: bool = false
@export var data: MyTileData = Constants.TILE_DATA.block

@export var sprite: Sprite2D = null
@export var hitbox: CollisionShape2D = null
@export var allow_area: Area2D = null
@export var deny_area: Area2D = null
@export var money_timer: Timer = null

var mouse_focus: bool = false
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
	
	if placed and mouse_focus and Input.is_action_just_pressed("remove"):
		Global.death_queue.append(self)
	

func check_root(visited: Array[Tile] = []) -> bool:
	if is_root:
		return true
	
	var res = false
	for n in neighbours:
		if n in visited: continue
		visited.append(self)
		res = res or n.check_root(visited)
	return res

func neighbour_die(who: Tile) -> void:
	neighbours.remove_at(neighbours.find(who))

func recheck_root() -> void:
	if !check_root():
		Global.death_queue.append(self)

func build() -> void:
	var real_cost = int(data.cost * pow(1.5, Global.tile_count[data.name]))
	
	if Global.money < real_cost:
		queue_free()
		return
	
	Global.money -= real_cost
	Global.tile_count[data.name] += 1
	placed = true
	hitbox.disabled = false
	sprite.modulate = Color(1, 1, 1)
	
	if data.cannon:
		var cannon: Cannon = preload("uid://b67pb5cwowwcb").instantiate()
		cannon.is_player = true
		cannon.data = data.cannon
		add_child(cannon)
	
	if data.money_income_delay > 0:
		money_timer.start(data.money_income_delay)
	
	for n in allow_area.get_overlapping_bodies():
		if !n is Tile: continue
		neighbours.append(n)
		n.neighbours.append(self)

func check_prebuild() -> bool:
	return allow_area.get_overlapping_bodies().size() > 0 and deny_area.get_overlapping_bodies().size() == 0

func _on_hit(dmg: int) -> void:
	health -= dmg
	if health <= 0:
		Global.death_queue.append(self)

func death() -> void:
	for n in neighbours:
		n.neighbour_die(self)
	Global.tile_count[data.name] -= 1
	queue_free()
	
	for n in neighbours:
		n.recheck_root()

func _on_mouse_entered() -> void:
	mouse_focus = true

func _on_mouse_exited() -> void:
	mouse_focus = false

func _on_money_income_timeout() -> void:
	Global.money += 1
