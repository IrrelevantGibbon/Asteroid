extends Area2D
signal hit
signal shoot


export var max_speed = 400
export var rotate_speed = 0.9
var speed_acceleration = 5
export(PackedScene) var laser_scene
var current_speed = 0
var screen_size
var can_shoot = true

func _ready():
	screen_size = get_viewport_rect().size

func set_position(pos: Vector2):
	position = pos

func _process(delta):
	_check_input(delta)
	
func _check_input(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		current_speed += abs(current_speed - max_speed)  if current_speed + speed_acceleration > max_speed else speed_acceleration
	if (current_speed > 0):
		velocity.y -= cos(deg2rad(rotation_degrees))
		velocity.x = sin(deg2rad(rotation_degrees))
	if Input.is_action_pressed("move_left"):
		rotation_degrees -= rotate_speed + 360 if rotation_degrees + rotate_speed < 0 else rotate_speed
	if Input.is_action_pressed("move_right"):
		rotation_degrees += rotate_speed - 360 if rotation_degrees + rotate_speed >= 360 else rotate_speed
	if Input.is_action_pressed("shoot") && can_shoot:
		emit_signal("shoot")
		$ShootTimer.start()
		can_shoot = false

	if velocity.length() > 0:
		velocity = velocity.normalized() * current_speed
	
	_update_position(delta,	velocity)
	if (current_speed > 0):
		current_speed -= 3.5
		
func _update_position(delta: float, velocity: Vector2):
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_Area2D_body_entered(body):
	if (body.name.find("Asteroid") != -1):
		body.on_laser_asteroid_entered()
#		queue_free()
	if (body.name.find("PowerU") != -1):
		var child = (body as RigidBody2D).get_child(0)
		_apply_power_up(child.animation)
		body.queue_free()
		
func _apply_power_up(power_up_name):
	if (power_up_name == "speed"):
		speed_acceleration += 5
	if (power_up_name == "amo"):
		$ShootTimer.wait_time -= 0.1
	if (power_up_name == "shield"):
		pass
