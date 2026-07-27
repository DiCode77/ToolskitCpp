#include "Switch.hpp"
#include "Switch.h"

Switch::Switch(void *parent, const visuals::point &point, const visuals::size &size) : Switch(){
    this->m_sw_bridge = new SwitchBridge(parent, point, size);
}

Switch::~Switch(){
    delete this->m_sw_bridge;
}

void Switch::bind(const std::function<void(const ControlStateValue&)> &func){
    this->m_sw_bridge->_bind(func);
};

SwitchBridge::SwitchBridge(){}
SwitchBridge::SwitchBridge(void *parent, const visuals::point &point, const visuals::size &size) : m_sw_delegate([[SwitchDelegate alloc] init]){
    if (parent != nullptr){
        this->m_ns_view = (__bridge NSView*)parent;
        this->m_sw_delegate.bridge = this;
        
        this->m_switch = [[NSSwitch alloc] initWithFrame:this->m_ns_view.bounds];
        this->m_switch.frame = NSMakeRect((CGFloat)point.GetX(), (CGFloat)point.GetY(), (CGFloat)size.GetX(), (CGFloat)size.GetY());
        this->m_switch.state = NSControlStateValueOff;
        
        [this->m_switch setTarget:this->m_sw_delegate];
        [this->m_switch setAction:@selector(toggleChanged:)];
        [this->m_ns_view addSubview:this->m_switch];
        [NSApp activateIgnoringOtherApps:YES];
    }else{
        [this->m_sw_delegate release];
    }
}

void SwitchBridge::_bind(const std::function<void(const ControlStateValue&)> &func){
    this->m_cell_button = func;
}

@implementation SwitchDelegate
- (void)toggleChanged:(NSSwitch*)sender{
    if (self.bridge != nullptr){
        if (self.bridge->m_cell_button){
            switch (sender.state) {
                case NSControlStateValueMixed:
                    self.bridge->m_cell_button(ControlStateValue::ControlStateValueMixed);
                    break;
                case NSControlStateValueOff:
                    self.bridge->m_cell_button(ControlStateValue::ControlStateValueOff);
                    break;
                case NSControlStateValueOn:
                    self.bridge->m_cell_button(ControlStateValue::ControlStateValueOn);
                    break;
            }
        }
    }
}
@end
