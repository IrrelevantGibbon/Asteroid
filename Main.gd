extends Node2D

export(PackedScene) var laser_scene
export(PackedScene) var asteroid_scene

func _ready():
	randomize()
	$MeteorTimer.start()
	$Ship.set_position($StartPosition.position)

func _on_Ship_shoot():
	var laser = laser_scene.instance()
	laser.set_ship_data($Ship.rotation_degrees, $Ship.position)
	add_child(laser)


func _on_meteorTimer_timeout():
		# Create a new instance of the asteroid scene.
	var asteroid = asteroid_scene.instance()

	# Choose a random location on Path2D.
	var asteroid_spawn_location = get_node("AstreroidPath/AsteroidSpawnLocation")
	asteroid_spawn_location.offset = randi()

	# Set the asteroid's direction perpendicular to the path direction.
	var direction = asteroid_spawn_location.rotation + PI / 2

	# Set the asteroid's position to a random location.
	asteroid.position = asteroid_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

	# Choose the velocity for the asteroid.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)

	# Spawn the asteroid by adding it to the Main scene.
	add_child(asteroid)

