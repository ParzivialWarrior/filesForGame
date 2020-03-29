extends KinematicBody

var speed = 8
var acceleartion = 20
var gravity = 9.5
var jump = 10

var mouse_sensitvity = 0.05 

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $head


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitvity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitvity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		
		
		
func _process(delta):
	
	direction = Vector3()
	
	if not is_on_floor():
		fall.y -= gravity * delta
		
	if Input.is_action_pressed("jump"):
		fall.y = jump
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
	
	elif Input.is_action_pressed("ui_leftmouse"):
		_on_MeleeHit_area_entered()

func _on_MeleeHit_area_entered(area):
		if area.is_in_group("hurtbox"):
		area.take_damage()
		
	
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleartion * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_MeleeHit2D_area_entered(area):
	pass # Replace with function body.
