extends Node

signal max_changed(new_max)
signal changed(new_amount)
export(int)var max_amount = 10 setget set_max
onready var current = max_amount setget set_current

func _ready():
	_intalize()
	
func set_max(new_max):
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
	
func set_current(new_value):
		current = clamp(current, 0, max_amount)
		emit_signal("changed", current)
			
	#if current == 0:
	#	emit_signal("deplated")
				
		
func _intialize():
		emit_signal("max_changed", max_amount)
		emit_signal("change", current)
			
		
		
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
