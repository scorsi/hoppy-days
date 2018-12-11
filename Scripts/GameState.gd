extends Node


export var _world_limit = 3000
export(Vector2) var _spawn_position
export(PackedScene) var _player_scene
export var _starting_lives = 3
export var _extra_life_cost = 20

var _lives
var _coins = 0


func _ready():
	Global.GameState = self
	_lives = _starting_lives
	_spawn_player()
	_update_GUI()


func _process(delta):
	if Global.Player.position.y > _world_limit:
		_end_game()


func pickup_coin():
	_coins += 1
	_animate_GUI("coin_up")
	if _coins > _extra_life_cost:
		_lives += _coins / _extra_life_cost
		_coins = _coins % _extra_life_cost
		_animate_GUI("live_up")
	_update_GUI()


func hurt_player():
	_lives -= 1
	_update_GUI()
	_animate_GUI("life_down")
	Global.Player.hurt()
	if _lives < 0:
		_end_game()


func _spawn_player():
	var new_player = _player_scene.instance()
	add_child(new_player)
	new_player.position = _spawn_position
	Global.Player = new_player


func _end_game():
	LevelManager.change_scene("GameOver")


func _update_GUI():
	Global.GUI.update(_coins, _lives)


func _animate_GUI(animation_name):
	Global.GUI.animate(animation_name)
