extends CharacterBody3D
@onready var spring_arm:SpringArm3D=$SpringArm3D
var object_class = preload("res://ball.tscn")
@onready var shoot_position= $MeshInstance3D2/Marker3D
@onready var mesh = $MeshInstance3D2
const SPEED = 10
const JUMP_VELOCITY = 4.5
var angular_acceleration:=7
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta):
	var root = get_tree().get_root().get_node("World")
	if Input.is_action_just_pressed("Shoot"):

		var object_instance = object_class.instantiate()
		object_instance.position = shoot_position.global_position
		object_instance.rotation.y=$MeshInstance3D2.rotation.y
		root.add_child(object_instance)
