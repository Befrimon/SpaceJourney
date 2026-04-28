extends Node

var current_scene: Node = null


var world_container: Node2D = null:
	set = assert_world

var canvas_container: CanvasLayer = null:
	set = assert_canvas

func assert_world(new_world: Node2D) -> void:
	world_container = new_world

func assert_canvas(new_canvas: CanvasLayer) -> void:
	canvas_container = new_canvas

func change_scene(scene: String) -> void:
	var packed: PackedScene = load(scene)
	
	if current_scene:
		current_scene.queue_free()
	current_scene = packed.instantiate()
	
	if current_scene is Node2D:
		world_container.add_child(current_scene)
	else:
		canvas_container.add_child(current_scene)
