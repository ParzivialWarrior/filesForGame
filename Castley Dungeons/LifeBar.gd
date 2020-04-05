extends HBoxContainer

var maximum_value = 10

func _on_interface_health_changed(health):
	$TextureProgress.value = "%s / %s" % [health, maximum_value]
