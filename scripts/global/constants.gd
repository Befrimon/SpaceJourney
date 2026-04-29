extends Node

const SCENES: Dictionary[StringName, String] = {
	"main_menu": "uid://l1lcblaw643f",
	"settings": "uid://de7jrpxcmw233",
	"main_game": "uid://xprumt385jx",
}

const TILE_DATA: Dictionary[StringName, MyTileData] = {
	"root": preload("uid://byi8oguqngvbh"),
	"block": preload("uid://c58nsa68doo2u"),
	"generator": preload("uid://bonxe5pryw2ao"),
	"cannon": preload("uid://cchrl52u3sjhq"),
	"rocket": preload("uid://05e2fn1etd3j"),
}

const CANNONS: Dictionary[StringName, CannonData] = {
	"default": preload("uid://dbapvwg7qkpo6"),
	"weak_enemy": preload("uid://di52tmqbwqqvs"),
}

const BULLETS: Dictionary[StringName, SpriteFrames] = {
	"player_default": preload("uid://drxgn5idkb5dg"),
	"enemy_default": preload("uid://da8l00tsi5la4"),
}

const ENEMIES: Dictionary[StringName, EnemyData] = {
	"bat": preload("uid://cbfjfoudi7xaq"),
	"elite_bat": preload("uid://y4apaclney6w"),
}

const BOSSES: Dictionary[StringName, BossData] = {
	"first": preload("uid://dnenks13db4q"),
}
