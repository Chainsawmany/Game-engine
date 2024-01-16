extends Node3D

var object_class = preload("res://enemy.tscn")
@onready var spawnpoint = $MeshInstance3D

func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var root = get_tree().get_root().get_node("World")
	print("enemyspawned")
	var object_instance = object_class.instantiate()
	object_instance.position = spawnpoint.global_position
	#object_instance.rotation.y=$MeshInstance3D2.rotation.y
	root.add_child(object_instance)
	pass # Replace with function body.
