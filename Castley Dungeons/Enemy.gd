extends KinematicBody

const MOVE_SPEED = 3

onready var raycast = $RayCast
#onready var anim_player = $ANimationPlayer

var player = null
var dead = false



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if dead:
		return
	if player == null:
		return
	var vec_to_player = player.translation - translation
	vec_to_player = vec_to_player.normalized()
	raycast.cast_to = vec_to_player * 1.5	
	
	#move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()
func kill():
	dead = true
	$CollisionShape.disabled = true
	
	
		
func set_player(p):
	player = p 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
