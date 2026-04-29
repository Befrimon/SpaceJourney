extends Control

const TAB_AUDIO: StringName = &"audio"
const TAB_CONTROLS: StringName = &"controls"

var active_tab: StringName = TAB_AUDIO

@onready var buttons: Dictionary[StringName, Button] = {
	TAB_AUDIO: $MarginContainer/VBoxContainer/TabsBar/MarginContainer/HBoxContainer/SoundSetBtn,
	TAB_CONTROLS: $MarginContainer/VBoxContainer/TabsBar/MarginContainer/HBoxContainer/ControlSetBtn,
}

@onready var pages: Dictionary[StringName, Control] = {
	TAB_AUDIO: $MarginContainer/VBoxContainer/Content/MarginContainer/AudioSettings,
	TAB_CONTROLS: $MarginContainer/VBoxContainer/Content/MarginContainer/ControlSettings,
}

func _ready() -> void:
	buttons[TAB_AUDIO].pressed.connect(_on_audio_tab_pressed)
	buttons[TAB_CONTROLS].pressed.connect(_on_controls_tab_pressed)

	set_tab(TAB_AUDIO)

func set_tab(tab: StringName) -> void:
	active_tab = tab
	_update_ui()

func _update_ui() -> void:
	for key: StringName in buttons.keys():
		var is_active: bool = key == active_tab
		buttons[key].button_pressed = is_active
		pages[key].visible = is_active

func _on_audio_tab_pressed() -> void:
	set_tab(TAB_AUDIO)

func _on_controls_tab_pressed() -> void:
	set_tab(TAB_CONTROLS)
