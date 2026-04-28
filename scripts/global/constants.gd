extends Node

const SCENES: Dictionary[StringName, String] = {
	"main_menu": "",
	"main_game": "uid://xprumt385jx",
}

const TILE_DATA: Dictionary[StringName, MyTileData] = {
	"root": preload("uid://byi8oguqngvbh"),
	"block": preload("uid://c58nsa68doo2u"),
}

const CANNONS: Dictionary[StringName, CannonData] = {
	"default": preload("uid://dbapvwg7qkpo6"),
}
