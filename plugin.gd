@tool
extends EditorPlugin

var attach_button_packedscene := preload("res://addons/godot_visualstudio_debugger/attach_to_vs22/attach_button.tscn")
var attach_button:Node

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		Douwco_ProfileGenerator.regenerate()

func _enter_tree():
	attach_button = attach_button_packedscene.instantiate()
	attach_button.plugin = self
	add_control_to_container(CONTAINER_TOOLBAR, attach_button)
	attach_button.get_parent().move_child(attach_button, -2)

func _exit_tree():
	attach_button.queue_free()

func enable_connect(enable: bool):
	if enable:
		add_autoload_singleton("attach", "res://addons/godot_visualstudio_debugger/attach_to_vs22/attach_singleton.gd")
	else:
		remove_autoload_singleton("attach")
