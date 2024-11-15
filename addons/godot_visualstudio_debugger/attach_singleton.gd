extends Node

func _ready():
	if OS.is_debug_build():
		print("starting vsjitdebugger...")
		OS.execute("vsjitdebugger", ["/p", str(OS.get_process_id())], [])
	else: queue_free()
