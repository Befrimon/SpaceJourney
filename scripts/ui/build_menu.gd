extends PanelContainer
@export var button_settings: Resource

@export var build_selector_path: NodePath = NodePath("../TempWorld/BuildSelector")
@export var module_catalog: ModuleCatalog = null
@export var menu_config: BuildMenuConfig = null

@onready var list: VBoxContainer = $ScrollContainer/ControlContainer

var _build_selector: Node = null
var _buttons: Dictionary = {} # Dictionary[StringName, Button]
var _active_block_id: StringName


func _ready() -> void:
	_build_selector = get_node_or_null(build_selector_path)
	if _build_selector == null:
		printerr("BuildSelector not found at path: %s from %s" % [build_selector_path, get_path()])

	assert(module_catalog, "ModuleCatalog not set in %s" % get_path())
	assert(list, "VBoxContainer is null at %s" % get_path())

	_create_block_buttons()

	# Select first block by default
	if _buttons.size() > 0:
		var first_block_id: StringName = StringName(_buttons.keys()[0])
		_select_block(first_block_id)

	# Initially update visibility
	_update_visibility()

	# Connect to mode changes
	GameState.mode_changed.connect(_on_mode_changed)


func _on_mode_changed(_new_mode: GameState.GameMode) -> void:
	_update_visibility()


func _update_visibility() -> void:
	visible = GameState.current_mode == GameState.GameMode.BUILDING


func _collect_block_ids() -> Array[StringName]:
	var ordered_ids: Array[StringName] = []
	var used: Dictionary = {}

	if menu_config != null:
		for block_id: StringName in menu_config.block_ids:
			if module_catalog.has_module(block_id) and not used.has(block_id):
				ordered_ids.append(block_id)
				used[block_id] = true

	for block_id: StringName in module_catalog.get_ids():
		if not used.has(block_id):
			ordered_ids.append(block_id)
			used[block_id] = true

	return ordered_ids


func _create_block_buttons() -> void:
	# Clear old rows
	for child: Node in list.get_children():
		child.queue_free()

	_buttons.clear()

	# Create one vertical row per module
	for block_id: StringName in _collect_block_ids():
		var entry: ModuleEntry = module_catalog.get_entry(block_id)

		if entry == null:
			printerr("Block ID '%s' not found in ModuleCatalog" % block_id)
			continue

		var row: CenterContainer = CenterContainer.new()

		var hbox: HBoxContainer = HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 8)

		var label: Label = Label.new()
		var display_name: String = entry.name if entry.name != "" else str(block_id)
		label.text = display_name.to_upper()

		var button: Button = UIButton.new()
		button.settings = button_settings
		button.toggle_mode = true
		button.text = str(entry.cost)

		button.pressed.connect(func() -> void:
			_on_block_button_pressed(block_id)
		)

		hbox.add_child(label)
		hbox.add_child(button)

		row.add_child(hbox)
		list.add_child(row)

		_buttons[block_id] = button


func _on_block_button_pressed(block_id: StringName) -> void:
	_select_block(block_id)


func _select_block(block_id: StringName) -> void:
	if _build_selector and _build_selector.has_method("select_block"):
		_build_selector.call("select_block", block_id)

	_active_block_id = block_id
	_update_toggle_state(block_id)


func _update_toggle_state(active_id: StringName) -> void:
	for block_id: StringName in _buttons:
		var button: Button = _buttons[block_id]
		button.button_pressed = (block_id == active_id)
