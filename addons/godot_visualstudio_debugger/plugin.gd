@tool
extends EditorPlugin

func _ready() -> void:
	var vs_launch_profile_sync := VSLaunchProfileSync.new()
	add_child(vs_launch_profile_sync)
