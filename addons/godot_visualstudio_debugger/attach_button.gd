@tool
extends Button


func _on_toggled(toggled_on: bool) -> void:
	var plugin := EditorPlugin.new()
	if toggled_on:
		plugin.add_autoload_singleton("attach", "res://addons/godot_visualstudio_debugger/attach_singleton.gd")
	else:
		plugin.remove_autoload_singleton("attach")

func _exit_tree() -> void:
	var plugin := EditorPlugin.new()
	plugin.add_autoload_singleton("attach", "res://addons/godot_visualstudio_debugger/attach_singleton.gd")
	plugin.remove_autoload_singleton("attach")
