extends PanelContainer
@export var button_settings: Resource
@export var list: VBoxContainer = null

var waiting_action: StringName = &""
var waiting_button: Button = null


func get_key_text(action: StringName) -> String:
	var events: Array[InputEvent] = InputMap.action_get_events(action)

	if events.is_empty():
		return "UNBOUND"

	var ev: InputEvent = events[0]

	if ev is InputEventKey:
		var key_ev: InputEventKey = ev as InputEventKey
		return OS.get_keycode_string(key_ev.physical_keycode)

	return "?"


func start_rebind(action: StringName, button: Button) -> void:
	waiting_action = action
	waiting_button = button
	button.text = "Press key..."


func build_list() -> void:
	for c: Node in list.get_children():
		c.queue_free()

	for action: StringName in InputMap.get_actions():
		if action.begins_with("ui_"):
			continue

		var row: CenterContainer = CenterContainer.new()

		var hbox: HBoxContainer = HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 8)

		var label: Label = Label.new()
		label.text = String(action).to_upper()

		var button: Button = UIButton.new()
		button.settings = button_settings
		button.text = get_key_text(action)

		button.pressed.connect(func() -> void:
			start_rebind(action, button)
		)

		hbox.add_child(label)
		hbox.add_child(button)

		row.add_child(hbox)
		list.add_child(row)


func _ready() -> void:
	assert(list, "VBoxContainer is null at " + str(get_path()))
	build_list()


func _input(event: InputEvent) -> void:
	if waiting_action == &"":
		return

	if not (event is InputEventKey):
		return

	var key_event: InputEventKey = event as InputEventKey

	if not key_event.pressed or key_event.echo:
		return

	get_viewport().set_input_as_handled()

	if key_event.keycode == KEY_ESCAPE:
		waiting_button.text = get_key_text(waiting_action)
		waiting_action = &""
		waiting_button = null
		return

	var new_code: Key = key_event.physical_keycode

	for action: StringName in InputMap.get_actions():
		for e: InputEvent in InputMap.action_get_events(action):
			if e is InputEventKey:
				var existing_key: InputEventKey = e as InputEventKey

				if existing_key.physical_keycode == new_code:
					waiting_button.text = "CONFLICT"
					return

	for e: InputEvent in InputMap.action_get_events(waiting_action):
		if e is InputEventKey:
			InputMap.action_erase_event(waiting_action, e)

	var new_event: InputEventKey = InputEventKey.new()
	new_event.physical_keycode = new_code

	InputMap.action_add_event(waiting_action, new_event)

	waiting_button.text = get_key_text(waiting_action)

	waiting_action = &""
	waiting_button = null
