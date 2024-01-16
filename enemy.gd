extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const SPEED = 100.0
var player_detected=false
var player= null
@export var health:=10
func _physics_process(delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized();
		apply_central_force(move_direction*SPEED)
	

func _on_player_detect_area_entered(body):
	if body.is_in_group("Player"):
		player=body
		player_detected=true


func _on_player_detect_area_exited(body):
	if body.is_in_group("Player"):
		player = null
		player_detected = false


func _on_bullet_hit_area_entered(body):
	if body.is_in_group("bullet"):
		health -= 1
		if health<=0:
			queue_free()
