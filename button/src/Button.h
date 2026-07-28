//
//  Button.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef ButtonBridge_hpp
#define ButtonBridge_hpp

#include <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#include <functional>

#include "Point.hpp"
#include "Size.hpp"

#include "Property.hpp"

class ButtonBridge;
@interface ButtonDelegate : NSObject
@property (nonatomic, assign) ButtonBridge *bridge;
@end

class ButtonBridge{
    NSView         *m_ns_view;
    NSButton       *m_ns_button;
    ButtonDelegate *m_button_delegate;
public:
    ButtonBridge();
    ButtonBridge(void*, const bttn::property&);
    ~ButtonBridge();
    
    bool Create(void*, const bttn::property&);
};

#endif
