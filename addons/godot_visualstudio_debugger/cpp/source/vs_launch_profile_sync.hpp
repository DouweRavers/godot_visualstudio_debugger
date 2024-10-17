#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/node.hpp>

using namespace godot;

class VSLaunchProfileSync : public Node
{
    GDCLASS(VSLaunchProfileSync, Node)

protected:
    static void _bind_methods(){}
    void _notification(int p_what);
    void generate_profile();

public:
    VSLaunchProfileSync(){}
    ~VSLaunchProfileSync(){}
};
