@tool
extends Button

var plugin:EditorPlugin

func _on_toggled(toggled_on):
	plugin.enable_connect(toggled_on)
