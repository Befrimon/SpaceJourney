extends TextureButton
class_name UITextureButton

@export var settings: UIButtonSettings

func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_hovered)


func _on_pressed() -> void:
	if settings == null:
		return
	PersistentAudio.play_stream(settings.click_stream)


func _on_hovered() -> void:
	if settings == null:
		return
	PersistentAudio.play_stream(settings.hover_stream)
