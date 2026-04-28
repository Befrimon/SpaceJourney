extends Label

func _ready() -> void:
	_update_display(GameState.get_cogs())
	GameState.cogs_changed.connect(_on_cogs_changed)

func _on_cogs_changed(new_cogs: int) -> void:
	_update_display(new_cogs)

func _update_display(cogs: int) -> void:
	text = "COGS: %d" % cogs
