extends Control

func _on_continue() -> void:
	Global.wave_infinity = true
	get_tree().paused = false
	queue_free()

func _on_main_menu() -> void:
	get_tree().paused = false
	SceneManager.change_scene(Constants.SCENES.main_menu)
