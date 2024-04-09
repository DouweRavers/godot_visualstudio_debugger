@tool
extends EditorPlugin

var watcher
func _enter_tree():
	watcher = VS22DebugProfileWatcher.new()
	EditorInterface.get_base_control().add_child(watcher)

func _exit_tree():
	watcher.free()
