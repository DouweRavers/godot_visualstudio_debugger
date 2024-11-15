@tool
extends EditorPlugin

var attach_button:Node

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		generate_launchsettings_file()

func _enter_tree():
	var play_project_button := search_play_project_button(EditorInterface.get_base_control())
	var attach_button_packedscene := preload("res://addons/godot_visualstudio_debugger/attach_button.tscn")
	attach_button = attach_button_packedscene.instantiate()
	play_project_button.add_sibling(attach_button)
	play_project_button.get_parent().move_child(attach_button,0)

func _exit_tree():
	attach_button.queue_free()

func search_play_project_button(node:Node)->Button:
	if node is Button and (node as Button).tooltip_text == "Play the project.":
		return (node as Button)
	for child in node.get_children():
		var button := search_play_project_button(child)
		if button is Button:
			return button as Button
	return null

func generate_launchsettings_file():
	var edited_scene:Node = EditorInterface.get_edited_scene_root()
	# edited scene properties
	var name = edited_scene.name
	var scene_path = edited_scene.scene_file_path.replace("res://", "./")
	var editor_path = OS.get_executable_path();
	# base profile
	var base_profile = FileAccess.open("res://addons/godot_visualstudio_debugger/launchSettingsBase.json", FileAccess.READ).get_as_text()
	# generate profile
	var profile = base_profile.replace("$EDITOR$", editor_path).replace("$NAME$", name).replace("$PATH$", scene_path)
	# save to Properties folder
	if(not DirAccess.dir_exists_absolute("res://Properties/")): DirAccess.make_dir_recursive_absolute("res://Properties/")
	var file = FileAccess.open("res://Properties/launchSettings.json", FileAccess.WRITE)
	file.store_string(profile)
