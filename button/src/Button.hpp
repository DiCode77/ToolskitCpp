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
    
    void set_title(const char*);
    const char *get_title();
    
    void set_size(const visuals::size&);
    void set_position(const visuals::point&);
    
    visuals::size  get_size() const;
    visuals::point get_position() const;
    
    bool is_enabled() const;
    bool is_hidden() const;
    bool is_bordered() const;
    bttn::state is_state() const;
    
    void set_enabled(bool);
    void set_hidden(bool);
    void set_bordered(bool);
    void set_state(const bttn::state&);
    
    void set_toggle(Button*);
    void remove_toggle(Button*);
    
    bool Create(void*, const bttn::property&);
    void bind(const std::function<void(const bttn::event&)>&);
};

#endif
