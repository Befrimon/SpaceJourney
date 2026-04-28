extends Control
const LOCALE_RU: StringName = &"ru"
const LOCALE_EN: StringName = &"en"

@export var game_scene: PackedScene
@export var settings_scene: PackedScene

func start_game() -> void:
	_change_scene(game_scene)


func exit_game() -> void:
	get_tree().quit()


func settings() -> void:
	_change_scene(settings_scene)


func _on_russian_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_RU)


func _on_american_btn_pressed() -> void:
	TranslationServer.set_locale(LOCALE_EN)


func _change_scene(scene: PackedScene) -> void:
	if scene != null:
		get_tree().change_scene_to_packed(scene)
