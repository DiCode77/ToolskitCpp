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
    ControlStateValueMixed,
    ControlStateValueOff,
    ControlStateValueOn
};

enum class size{
    ControlSizeRegular,
    ControlSizeSmall,
    ControlSizeMini,
    ControlSizeLarge,
    ControlSizeExtraLarge // for macOS >= 20.0
};

}
#endif
