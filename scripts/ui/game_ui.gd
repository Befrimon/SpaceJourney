extends Control

@export var ship_parent: Ship = null

@export_group("Shop")
@export var shop_animator: AnimationPlayer = null
@export var shop_button_group: ButtonGroup = null

@export_group("Info")
@export var money_label: Label = null
@export var wave_title: Label = null
@export var wave_label: Label = null
@export var wave_value: Label = null
@export var wave_count: Label = null

var shop_opened: bool = false

func _ready() -> void:
	shop_button_group.pressed.connect(_select_shop_tile)

func _process(_delta: float) -> void:
	money_label.text = "%d" % Global.money
	wave_count.text = "%d" % Global.wave
	
	if Global.wave_active:
		wave_title.text = TranslationServer.translate("ENEMY_LEFT")
		wave_label.text = "%d" % Global.enemy_count
		wave_value.text = ""
	else:
		wave_title.text = TranslationServer.translate("NEXT_WAVE")
		wave_label.text = "%d" % int(Global.wave_timer.time_left)
		wave_value.text = "s"
	
	
	if Input.is_action_just_pressed("switch_build"):
		if !shop_opened:
			shop_animator.play("default")
			shop_opened = true
		else:
			shop_animator.play_backwards()
			shop_opened = false

func _select_shop_tile(button: BaseButton) -> void:
	var data: MyTileData = button.get_meta("tile_data")
	ship_parent.shop_select.emit(data)
