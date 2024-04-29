extends Node

func _ready():
	if OS.is_debug_build(): 
		OS.execute("vsjitdebugger", ["/p", str(OS.get_process_id())], [])
	else: queue_free()
