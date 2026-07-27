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
    Switch(void*, const visuals::point&, const visuals::size&);
    ~Switch();
    
    visuals::point get_position();
    visuals::size  get_size();
    
    void set_point(const visuals::point&);
    void set_size(const visuals::size&);
    
    bool Create(void*, const visuals::point&, const visuals::size&);
    void bind(const std::function<void(const ControlStateValue&)>&);
};

#endif
