extends Node

var money: int = 0
var player_position: Vector2 = Vector2.ZERO
var death_queue: Array[Tile] = []

var tile_count: Dictionary[StringName, int] = {
	"root": 0,
	"block": 0,
	"generator": 0,
	"cannon": 0,
	"rocket": 0,
}

func _process(_delta: float) -> void:
	if !death_queue.is_empty():
		var a = death_queue.pop_front()
		if a: a.death()

#region Waves Control
var wave: int = 0
var enemy_count: int = 0
var wave_delay: int = 0
var wave_active: bool = false
var wave_timer: Timer = null
var wave_infinity: bool = false
var wave_speed: float = 1.0

func reset_wave() -> void:
	money = 5
	
	tile_count = {
		"root": 0,
		"block": 0,
		"generator": 0,
		"cannon": 0,
		"rocket": 0,
	}
	
	wave = 1
	wave_speed = 1.0
	wave_active = false
	wave_infinity = false
	enemy_count = randi_range(int((wave + 2) * 1.5), int((wave + 2) * 2.5))
	wave_delay = max(20, int(3 / max(1, wave)))

func next_wave() -> void:
	wave += 1
	wave_speed += float(wave) / 100.0
	enemy_count = randi_range(wave + 2, int((wave + 2) * 2.5))
	wave_delay = max(3, int(3 / max(1, wave)))

#endregion
