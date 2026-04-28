extends CharacterBody2D

@export var speed: float = 1e4
@export var tile_map: TileMapLayer = null
@export var preview: Sprite2D = null

const CELLS: Dictionary[StringName, Vector2i] = {
	"block": Vector2i(4, 2)
}

var build_mode: bool = false
var tile_graph: Dictionary[Vector2, Array] = {
	Vector2.ZERO: []
}

func _ready() -> void:
	assert(tile_map, "TileMap not set in %s" % get_path())
	assert(preview, "Preview not set in %s" % get_path())

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_build"):
		build_mode = !build_mode
		preview.visible = build_mode
	
	var mouse_pos = get_local_mouse_position()
	var tile_pos = Vector2i((mouse_pos + Vector2(sign(mouse_pos.x), sign(mouse_pos.y)) * 4) / 8)
	preview.position = tile_pos * 8
	
	if build_mode and Input.is_action_just_pressed("build"):
		tile_map.set_cell(tile_pos, 0, CELLS.block)

func _physics_process(delta: float) -> void:
	var x_dir = Input.get_axis("left", "right")
	var y_dir = Input.get_axis("up", "down")
	
	velocity = Vector2(x_dir, y_dir) * speed * delta

	move_and_slide()
