extends Node

var player_ui: AudioStreamPlayer

func _ready() -> void:
	player_ui = AudioStreamPlayer.new()
	add_child(player_ui)
	player_ui.bus = "SFX"

func play_stream(stream: AudioStream) -> void:
	player_ui.stream = stream
	player_ui.play()
