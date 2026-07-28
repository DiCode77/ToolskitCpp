//
//  Property.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Property_hpp
#define Property_hpp

namespace switch_control{

enum class state{
    ControlStateValueMixed = -1,
    ControlStateValueOff   = 0,
    ControlStateValueOn    = 1
};

enum class size{
    ControlSizeRegular,
    ControlSizeSmall,
    ControlSizeMini,
    ControlSizeLarge,
    ControlSizeExtraLarge // for macOS >= 20.0
};

const state state_default = state::ControlStateValueOff;
const size  size_default  = size::ControlSizeLarge;

}
#endif
