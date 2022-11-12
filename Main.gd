extends Node2D

export(PackedScene) var laser_scene
export(PackedScene) var asteroid_scene
export(PackedScene) var powerup_scene
var score

func _ready():
	randomize()
	_start_game()

func _on_Ship_shoot():
	var laser = laser_scene.instance()
	laser.set_ship_data($Ship.rotation_degrees, $Ship.position)
	add_child(laser)


func _on_meteorTimer_timeout():
	_add_scene(asteroid_scene.instance())

func _on_ScoreTimer_timeout():
	score += 1

func _start_game():
	score = 0
	$MeteorTimer.start()
	$PowerUpTimer.start()
	$ScoreTimer.start()
	$Ship.set_position($StartPosition.position)

func _emd_game():
	$MeteorTimer.start()
	$ScoreTimer.start()

func _on_PowerUpTimer_timeout():
	_add_scene(powerup_scene.instance())

func _add_scene(scene):
	var scene_spawn_location = get_node("AstreroidPath/AsteroidSpawnLocation")
	scene_spawn_location.offset = randi()
	var direction = scene_spawn_location.rotation + PI / 2
	scene.position = scene_spawn_location.position
	direction += rand_range(-PI / 4, PI / 4)
	scene.rotation = direction
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	scene.linear_velocity = velocity.rotated(direction)
	add_child(scene)
	
