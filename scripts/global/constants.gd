extends Node

const SCENES: Dictionary[StringName, String] = {
	"main_menu": "uid://l1lcblaw643f",
	"settings": "uid://de7jrpxcmw233",
	"main_game": "uid://xprumt385jx",
}

const TILE_DATA: Dictionary[StringName, MyTileData] = {
	"root": preload("uid://byi8oguqngvbh"),
	"block": preload("uid://c58nsa68doo2u"),
}

const CANNONS: Dictionary[StringName, CannonData] = {
	"default": preload("uid://dbapvwg7qkpo6"),
}
