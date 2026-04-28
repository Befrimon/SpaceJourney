extends PanelContainer

@onready var master: HSlider = $MarginContainer/VBoxContainer/MastSlider
@onready var music: HSlider = $MarginContainer/VBoxContainer/MusicSlider
@onready var sfx: HSlider = $MarginContainer/VBoxContainer/SFXSlider

func _on_master_changed(value: float) -> void:
	_set_bus_volume(&"Master", value)


func _on_music_changed(value: float) -> void:
	_set_bus_volume(&"Music", value)


func _on_sfx_changed(value: float) -> void:
	_set_bus_volume(&"SFX", value)

func _ready() -> void:
	master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))

	master.value_changed.connect(_on_master_changed)
	music.value_changed.connect(_on_music_changed)
	sfx.value_changed.connect(_on_sfx_changed)


func _set_bus_volume(bus_name: StringName, value: float) -> void:
	var clamped_value: float = maxf(value, 0.001)
	var db: float = linear_to_db(clamped_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db)
