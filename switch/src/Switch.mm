#include "Switch.hpp"
#include "Switch.h"

Switch::Switch(void *parent, const visuals::point &point, const visuals::size &size, const switch_control::state &state, const switch_control::size &size_sw) : Switch(){
    this->Create(parent, point, size, state, size_sw);
}

Switch::~Switch(){
    delete this->m_sw_bridge;
}

visuals::point Switch::get_position(){
    return this->m_sw_bridge->get_position();
}

visuals::size Switch::get_size(){
    return this->m_sw_bridge->get_size();
}

void Switch::set_point(const visuals::point &point){
    this->m_sw_bridge->set_point(point);
}

void Switch::set_size(const visuals::size &size){
    this->m_sw_bridge->set_size(size);
}

void Switch::set_enabled(bool ed){
    this->m_sw_bridge->set_enabled(ed);
}

void Switch::set_state(const switch_control::state &state){
    this->m_sw_bridge->set_state(state);
}

void Switch::set_size_control(const switch_control::size &size_sw){
    this->m_sw_bridge->set_size_control(size_sw);
}

bool Switch::Create(void *parent, const visuals::point &point, const visuals::size &size, const switch_control::state &state, const switch_control::size &size_sw){
    if (this->m_sw_bridge == nullptr){
        this->m_sw_bridge = new SwitchBridge(parent, point, size, state, size_sw);
        return true;
    }
    return false;
}

void Switch::bind(const std::function<void(const switch_control::state&)> &func){
    this->m_sw_bridge->_bind(func);
};

void Switch::Cell_Func(const switch_control::state &state){
    this->m_sw_bridge->CellFunc(state);
}

SwitchBridge::SwitchBridge() : m_switch(nil), m_sw_delegate([[SwitchDelegate alloc] init]){}
SwitchBridge::SwitchBridge(void *parent, const visuals::point &point, const visuals::size &size, const switch_control::state &state, const switch_control::size &size_sw) : SwitchBridge::SwitchBridge(){
    this->Create(parent, point, size, state, size_sw);
}

SwitchBridge::~SwitchBridge(){
    if (this->m_switch != nil){
        [this->m_switch release];
    }
    [this->m_sw_delegate release];
}

visuals::point SwitchBridge::get_position(){
    if (this->m_switch != nil){
        NSPoint point = this->m_switch.frame.origin;
        return {static_cast<double>(point.x), static_cast<double>(point.y)};
    }
    return {};
}

visuals::size SwitchBridge::get_size(){
    if (this->m_switch != nil){
        NSSize size = this->m_switch.frame.size;
        return {static_cast<double>(size.width), static_cast<double>(size.height)};
    }
    return {};
}

void SwitchBridge::set_point(const visuals::point &point){
    NSRect frame = this->m_switch.frame;
    frame.origin = NSMakePoint((CGFloat)point.GetX(), (CGFloat)point.GetY());
    this->m_switch.frame = frame;
}

void SwitchBridge::set_size(const visuals::size &size){
    NSRect frame = this->m_switch.frame;
    frame.size = NSMakeSize((CGFloat)size.GetX(), (CGFloat)size.GetY());
    this->m_switch.frame = frame;
}

void SwitchBridge::set_enabled(bool enabled){
    [this->m_switch setEnabled:(BOOL)enabled];
}

void SwitchBridge::set_state(const switch_control::state &state){
    switch (state) {
        case switch_control::state::ControlStateValueMixed:
            [this->m_switch setState:NSControlStateValueMixed];
            break;
        case switch_control::state::ControlStateValueOff:
            [this->m_switch setState:NSControlStateValueOff];
            break;
        case switch_control::state::ControlStateValueOn:
            [this->m_switch setState:NSControlStateValueOn];
            break;
    }
}

void SwitchBridge::set_size_control(const switch_control::size &size_sw){
    switch (size_sw) {
        case switch_control::size::ControlSizeRegular:
            [this->m_switch setControlSize:NSControlSizeRegular];
            break;
        case switch_control::size::ControlSizeSmall:
            [this->m_switch setControlSize:NSControlSizeSmall];
            break;
        case switch_control::size::ControlSizeMini:
            [this->m_switch setControlSize:NSControlSizeMini];
            break;
        case switch_control::size::ControlSizeLarge:
            [this->m_switch setControlSize:NSControlSizeLarge];
            break;
        case switch_control::size::ControlSizeExtraLarge:
            [this->m_switch setControlSize:NSControlSizeExtraLarge];
            break;
    }
}

bool SwitchBridge::Create(void *parent, const visuals::point &point, const visuals::size &size, const switch_control::state &state, const switch_control::size &size_sw){
    if (parent != nullptr){
        this->m_ns_view = (__bridge NSView*)parent;
        this->m_sw_delegate.bridge = this;
        
        this->m_switch = [NSSwitch alloc];
        
        NSRect rect{};
        
        if (point != visuals::default_position){
            rect.origin = CGPoint(point.GetX(), point.GetY());
        }else{
            rect.origin = CGPoint(0, 0);
        }
        
        if (size != visuals::default_size){
            rect.size = CGSize(size.GetX(), size.GetY());
        }else{
            rect.size = [this->m_switch intrinsicContentSize];
        }
        
        [this->m_switch initWithFrame:rect];
        [this->m_switch setState:(NSControlStateValue)state];
        [this->m_switch setControlSize:(NSControlSize)size_sw];
        [this->m_switch setTarget:this->m_sw_delegate];
        [this->m_switch setAction:@selector(toggleChanged:)];
        [this->m_ns_view addSubview:this->m_switch];
        
        return true;
    }
    return false;
}

void SwitchBridge::_bind(const std::function<void(const switch_control::state&)> &func){
    this->m_cell_button = func;
}

void SwitchBridge::CellFunc(const switch_control::state &state){
    if (this->m_cell_button){
        this->m_cell_button(state);
    }
}

@implementation SwitchDelegate
- (void)toggleChanged:(NSSwitch*)sender{
    if (self.bridge != nullptr){
        if (self.bridge->m_cell_button){
            switch (sender.state) {
                case NSControlStateValueMixed:
                    self.bridge->m_cell_button(switch_control::state::ControlStateValueMixed);
                    break;
                case NSControlStateValueOff:
                    self.bridge->m_cell_button(switch_control::state::ControlStateValueOff);
                    break;
                case NSControlStateValueOn:
                    self.bridge->m_cell_button(switch_control::state::ControlStateValueOn);
                    break;
            }
        }
    }
}
@end
