@tool
extends EditorPlugin

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		regenerate_launch_profile()

func regenerate_launch_profile():
	var active_scene:Node = EditorInterface.get_edited_scene_root()
	var name = active_scene.name
	var scene_path = active_scene.scene_file_path.replace("res://", "./")
	var editor_path = OS.get_executable_path();
	var base_profile = FileAccess.open("res://addons/douwco.visualstudio22_debug_profiles/launchSettingsBase.json", FileAccess.READ).get_as_text()
	var profile = base_profile.replace("$EDITOR$", editor_path).replace("$NAME$", name).replace("$PATH$", scene_path)
	if(not DirAccess.dir_exists_absolute("res://Properties/")): DirAccess.make_dir_recursive_absolute("res://Properties/")
	var file = FileAccess.open("res://Properties/launchSettings.json", FileAccess.WRITE)
	file.store_string(profile)
