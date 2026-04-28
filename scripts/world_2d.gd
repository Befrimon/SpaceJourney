extends Node2D

@export var enemy_container: Node2D = null
@export var wave_timer: Timer = null

func _ready() -> void:
	Global.next_wave()
	wave_timer.start(Global.wave_delay)
	Global.wave_timer = wave_timer

func _process(_delta: float) -> void:
	if Global.wave_active:
		Global.enemy_count = enemy_container.get_child_count()
	
	if Global.enemy_count == 0:
		Global.wave_active = false
		Global.next_wave()
		wave_timer.start(Global.wave_delay)

func _spawn_enemies() -> void:
	Global.wave_active = true
	for i in range(Global.enemy_count):
		var iter = 0
		while iter < 5 or !_try_spawn():
			iter += 1

func _try_spawn() -> bool:
	var enemy = preload("uid://n5jf0bgbamc7").instantiate()
	var enemy_position = Vector2(
		randf_range(-100, 500),
		randf_range(-100, 100),
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
	
	enemy.position = enemy_position
	enemy_container.add_child(enemy)
	
	return true
