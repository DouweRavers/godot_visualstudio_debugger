class_name VS22DebugProfileWatcher extends Node

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		regenerate_launch_profile()

func regenerate_launch_profile():
	var active_scene:Node = EditorInterface.get_edited_scene_root()
	var name = active_scene.name
	var path = active_scene.scene_file_path.replace("res://", "./")
	var base_profile = FileAccess.open("res://addons/dravers.visualstudio22_debug_profiles/launchSettingsBase.json", FileAccess.READ).get_as_text()
	var profile = base_profile.replace("$EDITOR$", OS.get_executable_path()).replace("$NAME$", name).replace("$PATH$", path)
	var file = FileAccess.open("res://Properties/launchSettings.json", FileAccess.WRITE)
	file.store_string(profile)
