#include "vs_launch_profile_sync.hpp"

#include <godot_cpp/classes/editor_interface.hpp>
#include <godot_cpp/classes/os.hpp>
#include <godot_cpp/classes/file_access.hpp>
#include <godot_cpp/classes/dir_access.hpp>
#include <godot_cpp/variant/string.hpp>

#define TEMPLATE_LAUNCH_FILE_PATH "res://addons/godot_visualstudio_debugger/launchSettingsBase.json"
#define PROPERTIES_PATH "res://Properties/"
#define GDIGNORE_PROPERTIES_PATH PROPERTIES_PATH ".gdignore"
#define LAUNCH_FILE_PATH PROPERTIES_PATH "launchSettings.json"

void VSLaunchProfileSync::_notification(int p_what)
{
    if(p_what == NOTIFICATION_APPLICATION_FOCUS_OUT){
        generate_profile();
    }
}

void VSLaunchProfileSync::generate_profile()
{
    Node* edited_scene = EditorInterface::get_singleton()->get_edited_scene_root();

    Ref<FileAccess> base_profile_file = FileAccess::open(TEMPLATE_LAUNCH_FILE_PATH, FileAccess::ModeFlags::READ);
    String base_profile_content = base_profile_file->get_as_text();
    base_profile_file->close();

    String profiles = base_profile_content
                        .replace("$NAME$", edited_scene->get_name())
                        .replace("$PATH$", edited_scene->get_scene_file_path().replace("res://", "./"))
                        .replace("$EDITOR$", OS::get_singleton()->get_executable_path());

    if(!DirAccess::dir_exists_absolute(PROPERTIES_PATH)){
        DirAccess::make_dir_recursive_absolute(PROPERTIES_PATH);
        Ref<FileAccess> gdignore_file = FileAccess::open(GDIGNORE_PROPERTIES_PATH, FileAccess::ModeFlags::WRITE);
        gdignore_file->close();
    }

    Ref<FileAccess> launch_settings_file = FileAccess::open(LAUNCH_FILE_PATH, FileAccess::ModeFlags::WRITE);
    launch_settings_file->store_string(profiles);
    launch_settings_file->close();
}
