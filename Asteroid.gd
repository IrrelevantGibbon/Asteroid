extends RigidBody2D

func _ready():
	var animations = $AnimatedSprite.frames.get_animation_names()
	animations.remove(7) # remove explosion index
	$AnimatedSprite.animation =  animations[randi() % animations.size()]
	
	# Changer la shape de l' objet en fonction de l'asteroid cree 
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func on_laser_asteroid_entered():
	$AnimatedSprite.play("explosion")
	$CollisionShape2D.set_deferred("disabled", true)

func _on_AnimatedSprite_animation_finished():
	queue_free()
