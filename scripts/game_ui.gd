extends Control

@export var ship_parent: Ship = null

@export var shop_animator: AnimationPlayer = null
@export var shop_button_group: ButtonGroup = null

@export var money_label: Label = null

var shop_opened: bool = false

func _ready() -> void:
	shop_button_group.pressed.connect(_select_shop_tile)

func _process(_delta: float) -> void:
	money_label.text = "%d" % Global.money
	
	if Input.is_action_just_pressed("switch_build"):
		pass

func _select_shop_tile(button: BaseButton) -> void:
	var data: MyTileData = button.get_meta("tile_data")
	ship_parent.shop_select.emit(data)
