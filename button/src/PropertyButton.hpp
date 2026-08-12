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
const visuals::size default_button_size = visuals::size(90, 20);

enum class btype{
    MomentaryLight,       /// Standard button: When pressed, it temporarily changes its appearance; when released, it returns to its original state. It does not retain its state.
    PushOnPushOff,        /// Toggle switch. First press → ON, second press → OFF. Remembers the setting.
    Toggle,               /// Toggle button. Pressing it toggles the state between ON and OFF.
    Switch,               /// A native macOS switch that looks similar to NSSwitch.
    Radio,                /// Radio button — a round selection button. It is typically used in a group to select a single option.
    MomentaryChange,      /// Temporarily changes the state/appearance when clicked; returns to its original state when released.
    OnOff,                /// A button with two states: ON/OFF.
    MomentaryPushIn,      /// A standard push button. When pressed, the button visually “depresses”; when released, it returns to its original position.
    Accelerator,          /// A special accelerator button designed for repeated or accelerated action when held down.
    MultiLevelAccelerator /// An “accelerator” option with multiple speed/intensity levels.
};

enum class bstyle{
    BezelStyleAutomatic           = 0,    /// The appearance of this bezel style is automatically determined based on the button's contents and position within the window. This bezel style is the default for all button initializers.
    BezelStylePush                = 1,    /// The standard system push button style.
    BezelStyleFlexiblePush        = 2,    /// A flexible-height variant of NSBezelStylePush.
    BezelStyleDisclosure          = 5,    /// An unbezeled button with a disclosure triangle.
    BezelStyleCircular            = 7,    /// A button with a circular bezel suitable for a small icon or single character.
    BezelStyleHelpButton          = 9,    /// A circular button with a question mark providing the standard Help button appearance.
    BezelStyleSmallSquare         = 10,   /// A button with squared edges and flexible height.
    BezelStyleToolbar             = 11,   /// A button style that is appropriate for use in a toolbar item.
    BezelStyleAccessoryBarAction  = 12,   /// A bezel style that is suitable for accessory and scope bars. This style is typically used for buttons that perform an action or for pop-up buttons.
    BezelStyleAccessoryBar        = 13,   /// A bezel style that is suitable for accessory and scope bars. This style is typically used for buttons with togglable state.
    BezelStylePushDisclosure      = 14,   /// A bezeled variant of NSBezelStyleDisclosure.
    BezelStyleBadge               = 15,   /// A bezel style that is typically used in table rows to display information about the row, such as a count.
    BezelStyleGlass               = 16,   /// A bezel style with a glass effect.
    BezelStyleShadowlessSquare    = 6,
    BezelStyleTexturedSquare      = 8,
};

enum class state{
    ControlStateValueMixed = -1,
    ControlStateValueOff   = 0,
    ControlStateValueOn    = 1
};

enum class img_scale{ // These are the display scaling settings associated with the button itself.
    ImageScaleProportionallyDown,
    ImageScaleAxesIndependently,
    ImageScaleNone,
    ImageScaleProportionallyUpOrDown
};

enum class img_pos{
    NoImage,
    ImageOnly,
    ImageLeft,
    ImageRight,
    ImageBelow,
    ImageAbove,
    ImageOverlaps,
    ImageLeading,
    ImageTrailing
};

struct colors{
    int r;
    int g;
    int b;
    int a;
    
    bool operator== (const colors &_c) const{
        return this->r == _c.r && this->g == _c.g && this->b == _c.b && this->a == _c.a;
    }
    
    bool operator!= (const colors &_c) const{
        return this->r != _c.r || this->g != _c.g || this->b != _c.b || this->a != _c.a;
    }
};

constexpr colors colors_default = { -1, -1, -1, -1};

struct img{
    const char         *dir        = nullptr;
    const visuals::size size       = visuals::default_size;
    const img_scale     scale      = img_scale::ImageScaleAxesIndependently;
    const img_pos       posit      = img_pos::ImageOnly;
    const bool          bauto_size = false;
};

struct property{
    const char    *title       = nullptr;
    visuals::point point       = visuals::default_position;
    visuals::size  size        = default_button_size;
    const btype    type        = btype::MomentaryLight;
    const bstyle   style       = bstyle::BezelStyleAutomatic;
    const state    state       = state::ControlStateValueOff;
    const bool     bordered    = true;
    const int      tag         = -1;
    const img      icon        = {};
    const colors   bezel_color = colors_default;
};

struct event{
    property prop;
    bool     enabled;
    bool     hidden;
};
}

#endif
