extends Control


func _on_restart() -> void:
	get_tree().paused = false
	SceneManager.change_scene(Constants.SCENES.main_game)


func _on_main_menu() -> void:
	get_tree().paused = false
	SceneManager.change_scene(Constants.SCENES.main_menu)
