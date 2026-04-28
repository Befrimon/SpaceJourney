extends Control


@export var is_open: bool = false
@export var animation_duration: float = 0.25

@onready var menu: Panel = $MenuPanel
@onready var toggle_btn: Button = $ToggleButton

var _tween: Tween

func _ready() -> void:
	var viewport_width: float = get_viewport().get_visible_rect().size.x
	
	# Start off-screen
	menu.offset_left = viewport_width
	toggle_btn.offset_left = viewport_width - toggle_btn.size.x
	
	toggle_btn.pressed.connect(_on_toggle_pressed)
	set_process_input(true)

func _on_toggle_pressed() -> void:
	is_open = not is_open

	if _tween:
		_tween.kill()

	var viewport_width: float = get_viewport().get_visible_rect().size.x

	_tween = create_tween()
	_tween.set_parallel(true) # IMPORTANT: animate both at once
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_OUT)

	if is_open:
		# Panel slides in
		_tween.tween_property(menu, "offset_left", 0, animation_duration)
		
		# Button moves with it (stick to panel edge)
		_tween.tween_property(toggle_btn, "offset_left", menu.size.x, animation_duration)
	else:
		# Panel slides out
		_tween.tween_property(menu, "offset_left", viewport_width, animation_duration)
		
		# Button goes back to screen edge
		_tween.tween_property(
			toggle_btn,
			"offset_left",
			viewport_width - toggle_btn.size.x,
			animation_duration
		)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_build_menu"):
		_on_toggle_pressed()
