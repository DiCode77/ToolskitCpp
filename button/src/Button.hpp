//
//  Button.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Button_hpp
#define Button_hpp

#include <functional>

#include "Point.hpp"
#include "Size.hpp"

#include "Property.hpp"

class ButtonBridge;
class Button{
    ButtonBridge *m_button_bridge;
public:
    Button();
    Button(void*, const bttn::property&);
    
    void set_size(const visuals::size&);
    void set_position(const visuals::point&);
    
    visuals::size  get_size() const;
    visuals::point get_position() const;
    
    bool Create(void*, const bttn::property&);
    void bind(const std::function<void(const bttn::event&)>&);
};

#endif
