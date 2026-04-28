extends Node

@export var world: Node2D = null
@export var canvas: CanvasLayer = null

func _ready() -> void:
	assert(world, "World not set in %s" % get_path())
	assert(canvas, "Canvas not set in %s" % get_path())
	
	SceneManager.assert_world(world)
	SceneManager.assert_canvas(canvas)
	
	SceneManager.change_scene(Constants.SCENES.main_game)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
