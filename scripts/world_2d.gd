extends Node2D
class_name World

@export var pointer_container: Node2D = null
@export var enemy_container: Node2D = null
@export var wave_timer: Timer = null
@export var bg_player: AudioStreamPlayer = null

func _ready() -> void:
	Global.reset_wave()
	wave_timer.start(Global.wave_delay)
	Global.wave_timer = wave_timer

func _process(_delta: float) -> void:
	if Global.wave_active:
		Global.enemy_count = enemy_container.get_child_count()
	
	if Global.enemy_count == 0:
		Global.wave_active = false
		Global.next_wave()
		wave_timer.start(Global.wave_delay)

var _spawn_left: int = 0
func _spawn_enemies() -> void:
	Global.wave_active = true
	if Global.wave == 10:
		_spawn_boss()
	
	_spawn_left = Global.enemy_count
	while _spawn_left > 0:
		var iter = 0
		while iter < 5 or !_try_spawn():
			iter += 1

func _spawn_boss() -> void:
	var boss: Boss = preload("uid://ql2x5lxw7wn1").instantiate()
	boss.data = Constants.BOSSES.first
	boss.world_link = self
	enemy_container.add_child(boss)
	
	var pointer = preload("uid://cxw3qq3stdqfc").instantiate()
	pointer.boss_target = boss
	pointer_container.add_child(pointer)

func _try_spawn() -> bool:
	var enemy: Enemy = preload("uid://n5jf0bgbamc7").instantiate()
	var enemy_position = Vector2(
		randf_range(-400, 1400),
		randf_range(-300, 225),
	)
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = enemy_position
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = 4
	
	var result = get_world_2d().direct_space_state.intersect_point(query)
	for body in result:
		if body.collider.has_meta("player_area"):
			return false
	
	if _spawn_left > 5 and randf() < (Global.wave - 3) / 10.0:
		enemy.data = Constants.ENEMIES.elite_bat
		_spawn_left -= 3
	else:
		enemy.data = Constants.ENEMIES.bat
		_spawn_left -= 1
	
	enemy.position = enemy_position
	enemy_container.add_child(enemy)
	
	var pointer = preload("uid://cxw3qq3stdqfc").instantiate()
	pointer.target = enemy
	pointer_container.add_child(pointer)
	
	return true

func direct_spawn(pos: Vector2) -> void:
	var enemy: Enemy = preload("uid://n5jf0bgbamc7").instantiate()
	enemy.position = pos
	if randf() < (Global.wave - 3) / 10.0:
		enemy.data = Constants.ENEMIES.elite_bat
	else:
		enemy.data = Constants.ENEMIES.bat
	enemy_container.add_child(enemy)
	
	var pointer = preload("uid://cxw3qq3stdqfc").instantiate()
	pointer.target = enemy
	pointer_container.add_child(pointer)
