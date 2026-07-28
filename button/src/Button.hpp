//
//  Button.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Button_hpp
#define Button_hpp

#include "Point.hpp"
#include "Size.hpp"

#include "Property.hpp"

class ButtonBridge;
class Button{
    ButtonBridge *m_button_bridge;
public:
    Button();
    Button(void*, const bttn::property&);
    
    bool Create(void*, const bttn::property&);
};

#endif
