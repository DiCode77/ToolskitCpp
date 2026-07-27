//
//  Switch.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Switch_hpp
#define Switch_hpp

#include "Size.hpp"
#include "Point.hpp"
#include "Property.hpp"

#include <functional>

class SwitchBridge;
class Switch{
    SwitchBridge *m_sw_bridge;
public:
    Switch() : m_sw_bridge(nullptr){}
    Switch(void*, const visuals::point& = visuals::default_position, const visuals::size& = visuals::default_size, const switch_control::size& = switch_control::size::ControlSizeLarge);
    ~Switch();
    
    visuals::point get_position();
    visuals::size  get_size();
    
    void set_point(const visuals::point&);
    void set_size(const visuals::size&);
    void set_enabled(bool);
    void set_state(const switch_control::state&);
    void set_size_control(const switch_control::size&);
    
    bool Create(void*, const visuals::point&, const visuals::size&, const switch_control::size&);
    void bind(const std::function<void(const switch_control::state&)>&);
    void Cell_Func(const switch_control::state&);
};

#endif
