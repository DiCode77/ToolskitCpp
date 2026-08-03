//
//  Property.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Property_button_hpp
#define Property_button_hpp

#include "Point.hpp"
#include "Size.hpp"

namespace bttn{
enum class btype{
    MomentaryLight,
    PushOnPushOff,
    Toggle,
    Switch,
    Radio,
    MomentaryChange,
    OnOff,
    MomentaryPushIn,
    Accelerator,
    MultiLevelAccelerator
};

struct property{
    const char    *title = nullptr;
    visuals::point point = visuals::default_position;
    visuals::size  size  = visuals::default_size;
    const btype    type  = btype::MomentaryPushIn;
};
}

#endif
