extends KinematicBody

var speed = 8
var sprint_speed = 10
var crouch_move_speed = 3
var crouch_speed = 20
var default_speed = 7
var sprinting = false
var acceleartion = 20
var gravity = 9.5
var jump = 5

var default_height = 1.5
var crouch_height = 0.5

var mouse_sensitvity = 0.05 

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $head
onready var sprint_timer = $SprintTimer
onready var pcap = $CollisionShape
onready var bonker = $HeadBonker

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		var direct_state = get_world().direct_space_state
		var collision = direct_state.intersect_ray(transform.origin, Vector3(0, 0, -20))
		
		if collision:
			print(collision.position)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitvity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitvity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		
		
		
func _process(delta):
	
	#var head_bonked = false
	
	speed = default_speed
	
	direction = Vector3()
	#if bonker.is_colliding():
	#	head_bonked = true
		
	if not is_on_floor():
		fall.y -= gravity * delta
		
	if Input.is_action_pressed("jump"):
		fall.y = jump
	#if head.bonked:
		#fall.y = 2
	
	if Input.is_action_pressed("ability") and not sprinting:
		sprinting = true
		sprint_timer.start()
	elif Input.is_action_just_pressed("ability") and not sprinting:
		sprinting = false
	
	if sprinting:
		speed = sprint_speed
		
	if Input.is_action_pressed("crouch"):
		pcap.shape.height -= crouch_speed * delta
		speed = crouch_move_speed
	else:
		pcap.shape.height += crouch_speed * delta
	
	pcap.shape.height = clamp(pcap.shape.height, crouch_height, default_height)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_move_model(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
		
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x

	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	if Input.is_action_pressed("attack"):
		
		print("hello world")
	
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleartion * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_Sprint_Timer_timeout():
	sprinting = false

