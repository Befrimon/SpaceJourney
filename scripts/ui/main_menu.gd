extends Control

@export var settings: Control = null

const LOCALE_RU: StringName = &"ru"
const LOCALE_EN: StringName = &"en"

func _start_game() -> void:
	SceneManager.change_scene(Constants.SCENES.main_game)

func _settings() -> void:
	settings.show()

func _exit_game() -> void:
	get_tree().quit()

func _on_russian_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_RU)

func _on_american_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_EN)
