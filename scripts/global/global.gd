extends Node

var money: int = 5
var player_position: Vector2 = Vector2.ZERO


## Waves Control
var wave: int = 0
var enemy_count: int = 0
var wave_delay: int = 0
var wave_active: bool = false
var wave_timer: Timer = null

func next_wave() -> void:
	wave += 1
	enemy_count = randi_range(wave + 2, int((wave + 2) * 2.5))
	wave_delay = max(3, int(20 / max(1, wave)))
