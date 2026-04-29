extends CharacterBody2D
class_name Boss

@export var data: BossData = null
@export var root: Tile = null
@export var notifier: VisibleOnScreenNotifier2D = null

var world_link: World = null
var on_screen: bool = false

func _ready() -> void:
	for pos in data.pattern:
		var tile: Tile = preload("uid://y4jq8vyyx4h2").instantiate()
		tile.data = Constants.TILE_DATA[data.pattern[pos]]
		tile.is_player = false
		tile.boss_parent = self
		add_child(tile)
		tile.position = pos * 8
		tile.build()

func _process(_delta: float) -> void:
	on_screen = notifier.is_on_screen()
	
	if !root:
		queue_free()
