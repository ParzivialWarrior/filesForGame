extends Control

signal health_changed(health)
signal key_changed(count)

func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	
func _on_Purse_keys_changed(count):
	emit_signal("key_changed", count)
