extends CharacterBody2D
class_name Ship

signal shop_select(new_data: MyTileData)

@export var speed: float = 1e4
@export var root: Tile = null
@export var preview_container: Node2D = null
@export var canvas: CanvasLayer = null

var current: MyTileData = Constants.TILE_DATA.block
var preview: Tile = null
var build_mode: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_build"):
		build_mode = !build_mode
		if build_mode:
			_recreate_preview()
		elif preview:
			preview.queue_free()
	
	var mouse_pos = get_local_mouse_position()
	var tile_pos = Vector2i((mouse_pos + Vector2(sign(mouse_pos.x), sign(mouse_pos.y)) * 4) / 8)
	if build_mode:
		preview.position = tile_pos * 8
	
	if build_mode and Input.is_action_just_pressed("build") and preview.check_prebuild():
		preview.build()
		_recreate_preview()
	
	if !root:
		var game_over = preload("uid://dn5c64myggs71").instantiate()
		canvas.add_child(game_over)
		get_tree().paused = true
	
	if Global.wave == 11 and !Global.wave_infinity:
		var game_win = preload("uid://chvp8hknjuv1c").instantiate()
		canvas.add_child(game_win)
		get_tree().paused = true

func _physics_process(delta: float) -> void:
	var x_dir = Input.get_axis("left", "right")
	var y_dir = Input.get_axis("up", "down")
	
	velocity = Vector2(x_dir, y_dir) * speed * delta

	move_and_slide()
	Global.player_position = global_position


func _on_shop_select(new_data: MyTileData) -> void:
	current = new_data
	if !preview:
		return
	preview.queue_free()
	_recreate_preview()

func _recreate_preview() -> void:
	preview = preload("uid://y4jq8vyyx4h2").instantiate()
	preview.data = current
	preview_container.add_child(preview)
	
