extends Area2D

export var speed = 600

func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y -= cos(deg2rad(rotation_degrees))
	velocity.x = sin(deg2rad(rotation_degrees))
	velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func set_ship_data(angle, vector_pos):
	position = vector_pos
	var velocity = Vector2.ZERO
	velocity.y -= cos(deg2rad(angle)) * 40
	velocity.x = sin(deg2rad(angle)) * 40
	position += velocity
	rotation_degrees = angle


func _on_Area2D_body_entered(body):
	body.on_laser_asteroid_entered()
