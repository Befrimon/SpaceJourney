extends Control

const LOCALE_RU: StringName = &"ru"
const LOCALE_EN: StringName = &"en"

func start_game() -> void:
	SceneManager.change_scene(Constants.SCENES.main_game)


func exit_game() -> void:
	get_tree().quit()


func settings() -> void:
	SceneManager.change_scene(Constants.SCENES.settings)


func _on_russian_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_RU)


func _on_american_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_EN)
