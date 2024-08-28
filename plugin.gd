@tool
class_name VSD_Plugin extends EditorPlugin

const launchfile_path := "res://addons/godot-visualstudio-debugger/launchSettingsBase.json"

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		generate_profile_file()

func generate_profile_file():
	var edited_scene:Node = EditorInterface.get_edited_scene_root()
	# edited scene properties
	var name = edited_scene.name
	var scene_path = edited_scene.scene_file_path.replace("res://", "./")
	var editor_path = OS.get_executable_path();
	# base profile
	var base_profile = FileAccess.open(launchfile_path, FileAccess.READ).get_as_text()
	# generate profile
	var profile = base_profile.replace("$EDITOR$", editor_path).replace("$NAME$", name).replace("$PATH$", scene_path)
	# save to Properties folder
	if(not DirAccess.dir_exists_absolute("res://Properties/")): 
		DirAccess.make_dir_recursive_absolute("res://Properties/")
		var ignore_file = FileAccess.open("res://Properties/.gdignore", FileAccess.WRITE)
		ignore_file.close()
	var file = FileAccess.open("res://Properties/launchSettings.json", FileAccess.WRITE)
	file.store_string(profile)
	file.close()
