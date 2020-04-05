extends NinePatchRect



func _on_interface_key_changed(count):
	$Number.text = str(count)
