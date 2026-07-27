//
//  Switch.h
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef SwitchBridge_hpp
#define SwitchBridge_hpp

#include <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#include <functional>

#include "Size.hpp"
#include "Point.hpp"
#include "Property.hpp"

@interface SwitchDelegate : NSObject
@property(nonatomic, assign) SwitchBridge *bridge;
@end

class SwitchBridge{
    NSView         *m_ns_view;
    NSSwitch       *m_switch;
    SwitchDelegate *m_sw_delegate = nullptr;
public:
    std::function<void(const ControlStateValue&)> m_cell_button;
public:
    SwitchBridge();
    SwitchBridge(void*, const visuals::point&, const visuals::size&);
    void _bind(const std::function<void(const ControlStateValue&)>&);
};

#endif
