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
    
    void bind(const std::function<void(const ControlStateValue&)>&);
};

#endif
