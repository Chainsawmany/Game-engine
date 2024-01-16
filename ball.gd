extends RigidBody3D

var speed :=10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	apply_central_impulse(global_transform.basis.z*speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
