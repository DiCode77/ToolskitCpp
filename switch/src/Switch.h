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
    std::function<void(const switch_control::state&)> m_cell_button;
public:
    SwitchBridge();
    SwitchBridge(void*, const visuals::point&, const visuals::size&, const switch_control::size&);
    ~SwitchBridge();
    
    visuals::point get_position();
    visuals::size  get_size();
    
    void set_point(const visuals::point&);
    void set_size(const visuals::size&);
    void set_enabled(bool);
    void set_state(const switch_control::state&);
    void set_size_control(const switch_control::size&);
    
    bool Create(void*, const visuals::point&, const visuals::size&, const switch_control::size&);
    void _bind(const std::function<void(const switch_control::state&)>&);
    void CellFunc(const switch_control::state&);
};

#endif
